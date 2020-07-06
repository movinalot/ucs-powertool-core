<#

.SYNOPSIS
                This script automates the upgrade of UCS firmware
                
.DESCRIPTION
                This script logs into Cisco.com, download firmware bundles to a local working directory, upload bundles to the target UCS domain and walk through all steps of the upgrade

.PARAMETERSET
                hfp: To upgrade all components infra as well as servers
                infraOnly: To upgrade only infra component

.EXAMPLE
                UCSMFirmwareUpdate.ps1 -ucs xx.xx.xx.xx -version 'x.x(xx)' -imagedir c:\work\images -hfp "all"
                UCSMFirmwareUpdate.ps1 -ucs xx.xx.xx.xx -version 'x.x(xx)' -imagedir c:\work\images -hfp "default"
                Upgrades all components of UCS
                -ucs -- UCS Manager IP -- Example: "1.2.3.4"
                -version -- UCS Manager version to upgrade 
                -imagedir -- Path to download firmware bundle
                -hfp -- Firmware Host Pack. Values can be "all" or "default"
                All parameters are mandatory
                The prompts that will always be presented to the user will be for Username and Password for UCS and for cisco software image download


.EXAMPLE
                UCSMFirmwareUpdate.ps1 -ucs xx.xx.xx.xx -version 'x.x(xx)' -imagedir c:\work\images -infraOnly
                Upgrade Infrastructure only portion of UCSM
                -infraOnly -- Optional SwitchParameter when specified upgrades Infrastructure only
                 
.NOTES
                Author: Eric Williams
                Email: ericwill@cisco.com
                Company: Cisco Systems, Inc.
                Version: v1.1
                Date: 06/05/2014
                Disclaimer: Code provided as-is.  No warranty implied or included.  This code is for example use only and not for production

.INPUTS
                UCSM IP Address
                UCS Manager version to upgrade
                Directory path to download firmware image bundles
                Switch Parameter to upgrade infrastructure only portion
                HFP Parameter specifies which HFP to be upgraded

.OUTPUTS
                None
                
.LINK
                https://communities.cisco.com/docs/DOC-36062

#>

param(
    [parameter(Mandatory=${true})][string]${version},
    [parameter(Mandatory=${true})][string]${ucs},
    [parameter(Mandatory=${true})][string]${imageDir},
    [parameter(ParameterSetName='hfp', Mandatory=${true})][ValidateSet("all","default")][string]${hfp},
	[parameter(ParameterSetName='infraOnly', Mandatory=${true})][Switch]${infraOnly}
)

function Set-LogFilePath($LogFile)
{
    Write-Host "Creating log file under directory ${LogFile}\Logs\"
    $Global:LogFile = "$LogFile\Logs\Script.$(Get-Date -Format yyyy-MM-dd.hh-mm-ss).log"
    if([System.IO.File]::Exists($Global:LogFile) -eq $false)
    {
        $null = New-Item -Path $Global:LogFile -ItemType File -Force
    }
}

function Write-Log
{
    [CmdletBinding()]
    param 
    ( 
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String] $Message
    )
    
    $lineNum = (Get-PSCallStack).ScriptLineNumber[1]
    $Message = "Line: $lineNum - $Message"

    $ErrorActionPreference = 'Stop'

    "Info: $(Get-Date -Format g): $Message" | Out-File $Global:LogFile -Append
    Write-Host $Message
}

function Write-ErrorLog
{
    [CmdletBinding()] 
    param ( 
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [object] $Message
    )
    
    $lineNum = (Get-PSCallStack).ScriptLineNumber[1]
    $Message = "Line: $lineNum - $Message"

    "Error: $(Get-Date -Format g):" | Out-File $Global:LogFile -Append
    $Message | Out-File $LogFile -Append
    Write-Error $Message
    $trash = Disconnect-Ucs -ErrorAction Ignore
    exit   
}

function Connect-UcsManager
{
    # IP address and credentials to access the management server software that manages 
    # firmware updates for the nodes of the solution.
	
    $ucsConnection = Connect-Ucs -Name ${ucs} -Credential ${ucsCred} -ErrorVariable errVar -ErrorAction SilentlyContinue
    if ($errVar)
    {
        Write-Log "Error attempting to connect to UCS Manager at $managementServerAddress. Details: $errVar"
        return $null
    }
    else
    {
        Write-Log "Connected to Cisco UCS Manager $managementServerAddress"
        return $ucsConnection
    }
}

function Wait-UcsManagerActivation
{
    $count = 0
    $ucsConnection = $null
    while ($ucsConnection -eq $null)
    {
        if ($count -eq 20)
        {
            Write-Log "Error creating a session to UCS Manager even after 20 attempts"
            return $null
        }
        Write-Log "Checking if UCS Manager $($Parameters.ManagementServerAddress) is reachable.."
        if ((Test-Connection -ComputerName ${ucs} -Quiet) -ne $true)
        {
            $count++
            Write-Log "UCS Manager is still not reachable.."
            Write-Log "Sleeping for 30 seconds.. "
            Start-Sleep -Seconds 30
            continue
        }
        $count++
        Write-Log "Attempt # $count - Trying to login to UCS Manager..."
        $ucsConnection = Connect-UcsManager
        if ($ucsConnection -eq $null)
        {
            Write-Log "Error creating a session to UCS Manager "
            Write-Log "Sleeping for 30 seconds..."
            Start-Sleep -Seconds 30
        }
        else
        {
            Write-Log "Successfully logged back into UCS Manager"
            return $ucsConnection
        }
    }
}

function Wait-UcsFabricInterconnectActivation($fiDetails)
{
    $count = 0
    $isComplete = $false
    do
    {
        if ($count -eq 20)
        {
            Write-Log "Error FI activation is still not completed even after 20 minutes. Exiting with error now"
            return $false
        }
        $count++
        Write-Log "Getting the status of FI $($fiDetails.Id)..."
        try 
        {		
            $fwStatus = $fiDetails | Get-UcsFirmwareStatus -ErrorAction Stop| Select OperState
            switch ($fwStatus.OperState)
            {
                { @("bad-image", "failed", "faulty-state") -contains $_ } { Write-Log "Firmware activation of the Fabric Interconnect $($fiDetails.Id) has failed. Status is $fwStatus"; $isComplete = $true; return $false }
                "ready" { Write-Log "Firmware activation of the Fabric Interconnect $($fiDetails.Id) is complete"; $isComplete = $true; return $true }
                { @("activating", "auto-activating", "auto-updating", "rebooting", "rebuilding", "scheduled", "set-startup", "throttled", "upgrading", "updating", "") -contains $_ }
                {
                    Write-Log "Firmware activation is in progress $fwStatus";
                    Write-Log "Sleeping for 1 minute...";
                    Start-Sleep -Seconds 60;
                    break
                }
            }			
        }
        catch
        {
            Write-Log "Failed to get the status of the firmware update process. $_.Exception"
            throw $_.Exception			
        }
    }
    while ($isComplete -eq $false)
}

function Wait-UcsServersActivation
{
    $count = 0
    $bladeServers = @()
    $rackServers = @()

    #Sleep for 15 seconds so that all the servers comes in upgrading state
    Start-Sleep -Seconds 15

    #get all servers for which firmware status is not ready and not in error or faulty state.
    $moNotInReadyState = Get-UcsServer | Get-UcsFirmwareStatus -Filter 'OperState -cne ready -and (OperState -cne "bad-image" -and OperState -cne failed -and OperState -cne "faulty-state")' | Get-UcsParent
    if ($moNotInReadyState.Count -gt 0)
    {
        Write-Log "Monitoring the state of below servers:"
        foreach ($mo in $moNotInReadyState)
        {
            Write-Log $mo.Dn
        }
    
        do
        {
            if ($count -eq 40)
            {
                Write-Log "Error servers activation is still not completed even after 2 hours. Exiting with error now"
                return $false
            }
            $count++
        
            Write-Log "Sleeping for 3 minutes...";
            Start-Sleep -Seconds 180;          
            
            try 
            {
                #Logs the operstate of all the servers.
                foreach($mo in $moNotInReadyState)
                {
                    $tmpOperState = $mo | Get-UcsFirmwareStatus | select OperState
                    $moDn = $mo.Dn
                    Write-Log "Server firmware activation for server: $moDn is in progress: $tmpOperState"
                }
                #exits from the monitoring if all the servers are in ready state.
                if (($moNotInReadyState | Get-UcsFirmwareStatus | ? {$_.OperState -ne "ready"}).Count -eq 0)
                {
                    Write-Log "Server firmware activation is done";
                    return $true
                }
            }
            catch
            {
                Write-Log "Failed to get the status of the firmware update process. $_.Exception"
                throw $_.Exception			
            }
        }
        while ($true)
    }
    else
    {
        Write-Log "No servers to Monitor. Please check server firmware status. Servers may be in 'ready', 'bad-image', 'failed' or 'faulty-state'."
    }

    return $true
}
function Ack-UcsFIRebootEvent
{
    $count = 0
	while ($fwAck -eq $null)
	{		
		$count++
		Write-Log "Checking if there is a Pending activity generated for the activation of the Primary FI"
		$fwAck = Get-UcsFirmwareAck -Filter 'OperState -ilike waiting-for-*'
		if ($fwAck -eq $null)
		{
			Write-Log "Pending activity is not generated yet sleeping for 1 minute and then retrying the operation.."
			Start-Sleep -Seconds 60
		}           
		if ($count -ge 40)			
		{
			Write-ErrorLog "Pending activity is not generated. This is an error case. Terminating firmware update"
		}   
	}
    Write-Log "UCS Manager has generated a pending activity for primary FI reboot."
	Write-Log "Acknowledging the reboot of the primary FI now"
	$trash = Get-UcsFirmwareAck -Filter 'OperState -ilike waiting-for-*' | Set-UcsFirmwareAck -AdminState "trigger-immediate" -Force
	Write-Log "Activation of the primary FI has started"
	Write-Log "This will take few minutes. Sleeping for 5 minutes.."
	Start-Sleep -Seconds 300
}

function Activate-UcsPrimaryFI
{
    $count = 0
	$isCompleted = $false
    $primaryFI = ""
	while (!$isCompleted)
	{
		$fwStatus = $null
		$count++
		if ($count -ge 20)
		{
			Write-ErrorLog "FI activation is still not completed even after 20 minutes. Exiting with error now"
		}
        if (Get-UcsStatus -ErrorAction SilentlyContinue -ErrorVariable errVar | ? { $_.HaConfiguration -eq "cluster" })
        {
            $primary = Get-UcsMgmtEntity -LeaderShip primary -ErrorAction SilentlyContinue -ErrorVariable errVar
		    if($primary -ne $null)
		    {
			    $fwStatus = Get-UcsNetworkElement -Id $primary.Id -ErrorAction SilentlyContinue -ErrorVariable errVar | Get-UcsFirmwareStatus | Select OperState
		    }
        }
        else
        {
            $primary = Get-UcsNetworkElement -ErrorAction SilentlyContinue -ErrorVariable errVar
			if($primary -ne $null)
			{
				$fwStatus = Get-UcsNetworkElement -ErrorAction SilentlyContinue -ErrorVariable errVar | Get-UcsFirmwareStatus | Select OperState
			}
        }
		
		if ( ($fwStatus -eq $null) -or ($primary -eq $null))
		{
			Write-Log "UCS Manager is not reachable.. Details: $errVar"
			Write-Log "UCS Manager connection is reset. Reconnecting.."
			$trash = Disconnect-Ucs -ErrorAction Ignore
			$ucsConnection = Wait-UcsManagerActivation
			if ($ucsConnection -eq $null)
			{
				Write-Log "ERROR: Unable to login back to the UCS Manager even after multiple retries."
				Write-Log "Terminating firmware update"
				Write-ErrorLog "Firmware Activation has failed"
			}
			else
			{
				#Setting the DefaultUcs so that we don't need to specify the handle for every method call
				$ExecutionContext.SessionState.PSVariable.Set("DefaultUcs", $ucsConnection)
				if (Get-UcsStatus | ? { $_.HaConfiguration -eq "cluster" })
                {
                    $primaryFI = Get-UcsNetworkElement -Id (Get-UcsMgmtEntity -Leadership primary).Id
                }
                else
                {
                    $primaryFI = Get-UcsNetworkElement
                }
				$primaryActivated = Wait-UcsFabricInterconnectActivation $primaryFI
				if (!$primaryActivated)
				{
					Write-Log "ERROR: Activation of firmware faled on the $($subordFI.Id)"
					Write-ErrorLog "Firmware Activation has failed"
				}
				else
				{
					$updatedVersion = $primaryFI | Get-UcsMgmtController | Get-UcsFirmwareRunning -Deployment system | Select PackageVersion
					Write-Log "Activation of firmware on $($primaryFI.Id) is successful. Updated version is $($updatedVersion.PackageVersion)"
					break;
				}
			}
		}
		else
		{
			Write-Log "Activation of the primary FI is still in progress $($fwStatus.OperState)"
			Write-Log "Sleeping for a minute.."
			Start-Sleep -Seconds 60
		}
	}
    $trash = Disconnect-Ucs -ErrorAction Ignore
}

Set-LogFilePath $imageDir

if ((Get-Module | where {$_.Name -ilike "Cisco.UcsManager"}).Name -ine "Cisco.UcsManager")
{
	Write-Log "Loading Module: Cisco UCS PowerTool Module"
	Write-Log ""
	Import-Module Cisco.UcsManager
}  

if ((Get-Module | where {$_.Name -ilike "Cisco.Ucs.Common"}).Name -ine "Cisco.Ucs.Common")
{
	Write-Log "Loading Module: Cisco UCS PowerTool Module"
	Write-Log ""
	Import-Module Cisco.Ucs.Common
}  	

# Script only supports one UCS Domain update at a time
$output = Set-UcsPowerToolConfiguration -SupportMultipleDefaultUcs $false

Try
{
    ${Error}.Clear()
	
    # Login into UCS
	Write-Log "Enter Credentials of UCS Manager to be upgraded to version: '$($version)'"
	${ucsCred} = Get-Credential -Message "Enter Credentials of UCS Manager to be upgraded"
	Write-Log ""
	
	Write-Log "Logging into UCS Domain: '$($ucs)'"
	Write-Log ""
	$ucsConnection = Connect-UcsManager
	#Setting the DefaultUcs so that we don't need to specify the handle for every method call
    $ExecutionContext.SessionState.PSVariable.Set("DefaultUcs", $ucsConnection)
    
	if (${Error}) 
	{
		Write-Log "Error creating a session to UCS Manager Domain: '$($ucs)'"
		Write-Log "     Error equals: ${Error}"
		Write-Log "     Exiting"
        exit
    }

    #Check if the FI belongs to 6300 series.
    $sixtyThreeSeriesFI = $false
    ${fiModel} = (Get-UcsNetworkElement).Model | Select-Object -First 1
    if ($fiModel -cmatch "^UCS-FI-(?<modelNum>63\d\d).*$")
    {
        $sixtyThreeSeriesFIfound = $true
    }

	${infraVersionA} = ${version} + 'A'
	${infraVersionB} = ${version} + 'B'
	${infraVersionC} = ${version} + 'C'
   
    ${versionSplit} = ${version}.Split("()")
    ${versionBundle} = ${versionSplit}[0] + "." + ${versionSplit}[1]
	
    ${bundle} = @()
	${ccoImageList} = @()
    if ($sixtyThreeSeriesFIfound)
    {
        ${aSeriesBundle} = "ucs-6300-k9-bundle-infra." + ${versionBundle} + ".A.bin"
    }
    else
    {
		${aSeriesBundle} = "ucs-k9-bundle-infra." + ${versionBundle} + ".A.bin"
    }
    
	if (${infraOnly} -eq $false)
	{
		${bSeriesBundle} = "ucs-k9-bundle-b-series." + ${versionBundle} + ".B.bin"
		${cSeriesBundle} = "ucs-k9-bundle-c-series." + ${versionBundle} + ".C.bin"
		${bundle} = @(${aSeriesBundle},${bSeriesBundle},${cSeriesBundle})
	}
	elseif (${infraOnly} -eq $true)
	{
        ${bundle} = @(${aSeriesBundle})
	}
    
	Write-Log "Starting Firmware download process to local directory: ${imageDir}"
	Write-Log ""
	
    foreach(${eachBundle} in ${bundle})
    {
        ${fileName} = ${imagedir} +  "\" + ${eachBundle}
         if( test-path -Path ${fileName})
         {
              Write-Log "Image File : '${eachBundle}' already exist in local directory: '${imageDir}'"
         }
         else
         {
              ${ccoImageList} += ${eachBundle}
         }
    }	
	
    if(${ccoImageList} -ne ${null})
    {
        Write-Log  "Enter Cisco.com (CCO) Credentials"
        ${ccoCred} = Get-Credential -Message "Enter Cisco.com (CCO) Credentials"
        foreach(${eachbundle} in ${ccoImageList})
        {
            [array]${ccoImage} += Get-UcsSoftwareImageList -AllReleases -Credential ${ccoCred} -ErrorAction Stop | where { $_.ImageName -match ${eachbundle}}
			Write-Log "Preparing to download UCS Manager version '$($version)' bundle file: '$($eachbundle)'"
        }
		${Error}.Clear()
        Write-Log  "Downloading UCS Manager version: '$($version)' bundles to local directory: $($imageDir)"
        Write-Log "Sleeping for 2 minutes ..."
        Start-Sleep -Seconds 120
		$output = ${ccoImage} | Get-UcsSoftwareImage -Path ${imageDir} -ErrorAction Stop
    }
	Write-Log "Firmware download process completed to local directory: ${imageDir}"
	Write-Log ""
	
    foreach (${image} in ${bundle})
    {
		Write-Log "Checking if image file: '$($image)' is already uploaded to UCS Domain: '$($ucs)'"
		${firmwarePackage} = Get-UcsFirmwarePackage -Name ${image}
        ${deleted} = $false
        if (${firmwarePackage})
        {
           	# Check if all the images within the package are present by looking at presence
            ${deleted} = ${firmwarePackage} | Get-UcsFirmwareDistImage | ? { $_.ImageDeleted -ne ""}
        }
    
		if (${deleted} -or !${firmwarePackage})
        {
            $Error.Clear()
            # If Image does not exist on FI, uplaod
            $fileName = ${imageDir} +  "\" + ${image}
            if((Get-UcsFirmwareDownloader -FileName ${image} -TransferState failed).count -ne 0)
            {
                Write-ErrorLog "Image: '$($image)' already exists under Download Tasks in failed state. Exiting..."
            }
			Write-Log "Uploading image file: '$($image)' to UCS Domain: '$($ucs)'"
            $trash = Send-UcsFirmware -LiteralPath $fileName | Watch-Ucs -Property TransferState -SuccessValue downloaded -FailureValue failed -PollSec 30 -TimeoutSec 600 -ErrorAction SilentlyContinue
            if ($Error -ne "")
            {
                Write-ErrorLog "Error uploading image: '$($image)' to UCS Domain: '$($ucs)'. Please check Download Tasks for details."
            }
        	Write-Log "Upload of image file: '$($image)' to UCS Domain: '$($ucs)' completed"
			Write-Log ""  
		}
		else
		{
			Write-Log "Image file: '$($image)' is already uploaded to UCS Domain: '$($ucs)'"
			Write-Log ""  
		}
	}

	# Check if the status of the firmware boot unit is ready before proceeding with the firmware update
	if (!(Get-UcsNetworkElement | Get-UcsMgmtController | Get-UcsFirmwareBootDefinition  | Get-UcsFirmwareBootUnit | Where-Object { $_.OperState -eq 'ready'}))
	{
		Write-ErrorLog "Fabric Interconnect is not in ready state. Can't proceed with Firmware update."
	}

	# Start the Firmware Auto Install for the Infrastructure update. This will take care of updating the UCS Manager
    # both the Fabric Interconnects. 
    $activatedVersion = Get-UcsMgmtController -Subject system | Get-UcsFirmwareRunning -Type system | Select Version

	if ($activatedVersion.Version -ne $version)
	{
        Write-Log "Triggering the auto install of the infrastructure firmware  to $aSeriesBundle"
	    try 
        {
		    $trash = Start-UcsTransaction
		    $trash = Get-UcsOrg -Level root | Get-UcsFirmwareInfraPack -Name "default" -LimitScope | Set-UcsFirmwareInfraPack -ForceDeploy "yes" -InfraBundleVersion ${infraVersionA} -Force
		    $trash = Get-UcsSchedule -Name "infra-fw" | Get-UcsOnetimeOccurrence -Name "infra-fw" | Set-UcsOnetimeOccurrence -Date (Get-UcsTopSystem).CurrentTime -Force
		    $trash = Complete-UcsTransaction -ErrorAction Stop | Out-Null
	    }
	    catch 
	    {
		    Write-ErrorLog "Failed to start firmware auto install process. Details: $_.Exception"		
	    }
        
        Write-Log "Waiting until UCS Manager restarts"
        $trash = Disconnect-Ucs -ErrorAction Ignore
        Write-Log "Sleeping for 5 minutes ..."
        Start-Sleep -Seconds 300
        $ucsConnection = Wait-UcsManagerActivation
	    #Setting the DefaultUcs so that we don't need to specify the handle for every method call
        $ExecutionContext.SessionState.PSVariable.Set("DefaultUcs", $ucsConnection)
        #Check if UCSM got activated to the new version. 
        Write-Log "Checking the status of the firmware installation"
	    #---->
	    $activatedVersion = Get-UcsMgmtController -Subject system | Get-UcsFirmwareRunning -Type system | Select Version

	    if ($activatedVersion.Version -eq $version)
	    {
		    Write-Log "UCS Manager is activated to the $activatedVersion successfully"
	    }
	    else
	    {
		    Write-Log "Activation has failed so terminating the update process"
		    Write-ErrorLog "UCS Manager is at $activatedVersion version"
	    }
	
	    Start-Sleep -Seconds 60
        Write-Log "Checking the status of the FI activation"
        # Now check for the status of the FI activation. As part of the auto install first the secondary FI will be activated.
	    if (Get-UcsStatus | ? { $_.HaConfiguration -eq "cluster" })
	    {
		    while ($subordFIActivated -eq $null) 
		    {			
			    try
			    {
				    $subordFI = Get-UcsNetworkElement -Id (Get-UcsMgmtEntity -Leadership subordinate -ErrorAction Stop).Id	-ErrorAction Stop
				    $subordFIActivated = Wait-UcsFabricInterconnectActivation $subordFI                  
			    }
			    catch
			    {
				    Write-Log "Failed to get the status $_.Exception"
				    $trash = Disconnect-Ucs -ErrorAction Ignore
				    $ucsConnection = Wait-UcsManagerActivation
				    if ($ucsConnection -eq $null)
				    {
					    Write-ErrorLog "Unable to connect to the UCS Manager. Terminating the process.."
				    }
				    #Setting the DefaultUcs so that we don't need to specify the handle for every method call
				    $ExecutionContext.SessionState.PSVariable.Set("DefaultUcs", $ucsConnection)		
			    }
		    }
		    if (!$subordFIActivated)
		    {
			    Write-ErrorLog "Activation of firmware failed on the $($subordFI.Id)"
		    }
		    else
		    {
			    $updatedVersion = $subordFI | Get-UcsMgmtController | Get-UcsFirmwareRunning -Deployment system | Select PackageVersion
			    Write-Log "Activation of firmware on $($subordFI.Id) is successful."
			    Start-Sleep -Seconds 30
			    
                Ack-UcsFIRebootEvent
                Activate-UcsPrimaryFI
		    }
	    }
	    else
	    {
            Ack-UcsFIRebootEvent
            Activate-UcsPrimaryFI
	    }
    }
    else
    {
        Write-Log "UCS Manager is already at $activatedVersion version. Skipping FI upgrade..."
    }

	#=====================>>>>>>>>>>>Server Firmware Upgrade<<<<<<<<<<================================
	if (${infraOnly} -eq $false)
    {
        $Error.Clear()
        $trash = Disconnect-Ucs -ErrorAction Ignore
        $ucsConnection = Connect-UcsManager
	    #Setting the DefaultUcs so that we don't need to specify the handle for every method call
        $ExecutionContext.SessionState.PSVariable.Set("DefaultUcs", $ucsConnection)

        try
	    {
            if($hfp -eq "all")
            {
                $fwCompHostPackInfo = Get-UcsServiceProfile | select PnDn, OperHostFwPolicyName
                $fwCompHostPackDnList = @("org-root/fw-host-pack-default")
                foreach($eachfwCompHostPackInfo in $fwCompHostPackInfo)
                {
                    if (!($eachfwCompHostPackInfo.PnDn -eq "" -or $eachfwCompHostPackInfo.OperHostFwPolicyName -eq ""))
                    {
                        if(!$fwCompHostPackDnList.Contains($eachfwCompHostPackInfo.OperHostFwPolicyName))
                        {
                            $fwCompHostPackDnList += $eachfwCompHostPackInfo.OperHostFwPolicyName
                        }
                    }
                }
            }
            elseif($hfp -eq "default")
            {
                $fwCompHostPackDnList = @("org-root/fw-host-pack-default")
            }

            $fwCompHostPacks = $fwCompHostPackDnList | %{Get-UcsFirmwareComputeHostPack -Dn $_ -PolicyOwner local}

		    #$trash = Get-UcsOrg -Level root | Add-UcsFirmwareComputeHostPack -ModifyPresent -BladeBundleVersion ${infraVersionB} -Name "default" -RackBundleVersion ${infraVersionC} -ErrorAction Stop
            $trash = $fwCompHostPacks | Set-UcsFirmwareComputeHostPack -BladeBundleVersion ${infraVersionB} -RackBundleVersion ${infraVersionC} -Force -ErrorAction Stop
		    Write-Log "Triggered Server firmware upgrade. Modified Host Firmware Package. Version=${version}"

            while ($serverActivated -eq $null) 
		    {			
			    try
			    {
				    $serverActivated = Wait-UcsServersActivation               
			    }
			    catch
			    {
				    Write-Log "Failed to get the status $_.Exception"
			    }
		    }
	    }
	    catch
	    {
		    Write-Error "Failed modifying Host Firmware Package Version=${version}"
            Write-Log ${Error}
            $trash = Disconnect-Ucs -ErrorAction Ignore
            exit
	    }
    }
	#=====================>>>>>>>>>>>Server Firmware Upgrade<<<<<<<<<<================================
	$trash = Disconnect-Ucs -ErrorAction Ignore
    Write-Log "Firmware update process completed."
    #return $true
}
Catch
{
	if (${Error} -like "*In order to download software, you must accept the EULA*")
	{
		Write-Log "Error occurred in script:"
		Write-Log " In order to download software, you must accept the EULA. You will receive an email within 24 hours which will have details on accepting EULA.`
		Once you accept the EULA by following the instructions mentioned in the email, re-run this script to proceed."
		$trash = Disconnect-Ucs -ErrorAction Ignore
		exit
	}
	else
	{
		Write-Log "Error occurred in script:"
		Write-Log ${Error}
		$trash = Disconnect-Ucs -ErrorAction Ignore
		exit
	}
}


# SIG # Begin signature block
# MIIY7wYJKoZIhvcNAQcCoIIY4DCCGNwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAFean1aNIurzYx
# rSh0MpxnC0xllFKzKzqznsevSrtbAaCCE08wggQVMIIC/aADAgECAgsEAAAAAAEx
# icZQBDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3Qg
# Q0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2ln
# bjAeFw0xMTA4MDIxMDAwMDBaFw0yOTAzMjkxMDAwMDBaMFsxCzAJBgNVBAYTAkJF
# MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
# IFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAtIEcyMIIBIjANBgkqhkiG9w0BAQEF
# AAOCAQ8AMIIBCgKCAQEAqpuOw6sRUSUBtpaU4k/YwQj2RiPZRcWVl1urGr/SbFfJ
# MwYfoA/GPH5TSHq/nYeer+7DjEfhQuzj46FKbAwXxKbBuc1b8R5EiY7+C94hWBPu
# TcjFZwscsrPxNHaRossHbTfFoEcmAhWkkJGpeZ7X61edK3wi2BTX8QceeCI2a3d5
# r6/5f45O4bUIMf3q7UtxYowj8QM5j0R5tnYDV56tLwhG3NKMvPSOdM7IaGlRdhGL
# D10kWxlUPSbMQI2CJxtZIH1Z9pOAjvgqOP1roEBlH1d2zFuOBE8sqNuEUBNPxtyL
# ufjdaUyI65x7MCb8eli7WbwUcpKBV7d2ydiACoBuCQIDAQABo4HoMIHlMA4GA1Ud
# DwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBSSIadKlV1k
# sJu0HuYAN0fmnUErTDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYm
# aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wNgYDVR0fBC8w
# LTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLm5ldC9yb290LXIzLmNybDAf
# BgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOC
# AQEABFaCSnzQzsm/NmbRvjWek2yX6AbOMRhZ+WxBX4AuwEIluBjH/NSxN8RooM8o
# agN0S2OXhXdhO9cv4/W9M6KSfREfnops7yyw9GKNNnPRFjbxvF7stICYePzSdnno
# 4SGU4B/EouGqZ9uznHPlQCLPOc7b5neVp7uyy/YZhp2fyNSYBbJxb051rvE9ZGo7
# Xk5GpipdCJLxo/MddL9iDSOMXCo4ldLA1c3PiNofKLW6gWlkKrWmotVzr9xG2wSu
# kdduxZi61EfEVnSAR3hYjL7vK/3sbL/RlPe/UOB74JD9IBh4GCJdCC6MHKCX8x2Z
# faOdkdMGRE4EbnocIOM28LZQuTCCBMYwggOuoAMCAQICDCRUuH8eFFOtN/qheDAN
# BgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2ln
# biBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBT
# SEEyNTYgLSBHMjAeFw0xODAyMTkwMDAwMDBaFw0yOTAzMTgxMDAwMDBaMDsxOTA3
# BgNVBAMMMEdsb2JhbFNpZ24gVFNBIGZvciBNUyBBdXRoZW50aWNvZGUgYWR2YW5j
# ZWQgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANl4YaGWrhL/
# o/8n9kRge2pWLWfjX58xkipI7fkFhA5tTiJWytiZl45pyp97DwjIKito0ShhK5/k
# Ju66uPew7F5qG+JYtbS9HQntzeg91Gb/viIibTYmzxF4l+lVACjD6TdOvRnlF4RI
# shwhrexz0vOop+lf6DXOhROnIpusgun+8V/EElqx9wxA5tKg4E1o0O0MDBAdjwVf
# ZFX5uyhHBgzYBj83wyY2JYx7DyeIXDgxpQH2XmTeg8AUXODn0l7MjeojgBkqs2Iu
# YMeqZ9azQO5Sf1YM79kF15UgXYUVQM9ekZVRnkYaF5G+wcAHdbJL9za6xVRsX4ob
# +w0oYciJ8BUCAwEAAaOCAagwggGkMA4GA1UdDwEB/wQEAwIHgDBMBgNVHSAERTBD
# MEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
# aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5j
# b20vZ3MvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3JsMIGYBggrBgEFBQcBAQSBizCB
# iDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
# cnQvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3J0MDwGCCsGAQUFBzABhjBodHRwOi8v
# b2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3N0aW1lc3RhbXBpbmdzaGEyZzIwHQYDVR0O
# BBYEFNSHuI3m5UA8nVoGY8ZFhNnduxzDMB8GA1UdIwQYMBaAFJIhp0qVXWSwm7Qe
# 5gA3R+adQStMMA0GCSqGSIb3DQEBCwUAA4IBAQAkclClDLxACabB9NWCak5BX87H
# iDnT5Hz5Imw4eLj0uvdr4STrnXzNSKyL7LV2TI/cgmkIlue64We28Ka/GAhC4evN
# GVg5pRFhI9YZ1wDpu9L5X0H7BD7+iiBgDNFPI1oZGhjv2Mbe1l9UoXqT4bZ3hcD7
# sUbECa4vU/uVnI4m4krkxOY8Ne+6xtm5xc3NB5tjuz0PYbxVfCMQtYyKo9JoRbFA
# uqDdPBsVQLhJeG/llMBtVks89hIq1IXzSBMF4bswRQpBt3ySbr5OkmCCyltk5lXT
# 0gfenV+boQHtm/DDXbsZ8BgMmqAc6WoICz3pZpendR4PvyjXCSMN4hb6uvM0MIIF
# MDCCBBigAwIBAgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0BAQsFADBlMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3Qg
# Q0EwHhcNMTMxMDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQswCQYDVQQGEwJV
# UzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQu
# Y29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWdu
# aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+NOzHH8OEa9n
# dwfTCzFJGc/Q+0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ1DcZ17aq8JyG
# pdglrA55KDp+6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0sSgmuyRpwsJS
# 8hRniolF1C2ho+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6scKKrzn/pfMuS
# oeU7MRzP6vIK5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4TzrGdOtcT3jNEg
# JSPrCGQ+UpbB8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg0A9kczyen6Yz
# qf0Z3yWT0QIDAQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8B
# Af8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUHAQEEbTBrMCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKG
# N2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJv
# b3RDQS5jcnQwgYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0
# LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaGNGh0dHA6Ly9j
# cmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwTwYD
# VR0gBEgwRjA4BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3
# LmRpZ2ljZXJ0LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYEFFrEuXsqCqOl
# 6nEDwGD5LfZldQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA0G
# CSqGSIb3DQEBCwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06GsTvMGHXfgtg
# /cM9D8Svi/3vKt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5jDhNLrddfRHnz
# NhQGivecRk5c/5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgCPC6Ro8AlEeKc
# FEehemhor5unXCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIysjaKJAL+L3J+
# HNdJRZboWR3p+nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4GbT8aTEAb8B4H6
# i9r5gkn3Ym6hU/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIFNDCCBBygAwIBAgIQ
# D2NcG1fgU7fI95cZu49i0jANBgkqhkiG9w0BAQsFADByMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWduaW5n
# IENBMB4XDTE5MTEyOTAwMDAwMFoXDTIyMTIwNzEyMDAwMFowcTELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExETAPBgNVBAcTCFNhbiBKb3NlMRwwGgYD
# VQQKExNDSVNDTyBTWVNURU1TLCBJTkMuMRwwGgYDVQQDExNDSVNDTyBTWVNURU1T
# LCBJTkMuMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqsEvGzii5EVJ
# /A3QD6I9UTbiLANzg5WDqRoushmxa+uo1BekikoZH1L61I1Ra+7pv+Xvksik6k4a
# dmQ0ICevh9sIh1il3eXK43vBuSR1WD/SKwnTvFiEUAcx3v1KZZwRB8EGPEeo9CUJ
# c7X+OFPdAcBeACnqErbROX8ZNcENcK/E76Kco+2oxoP/ky/X1yWS8QrqQj3rNmqO
# Das+cqcnGs0fDSA9A57Z1tARA8XnpP+CEMyJnfe/aEDqTbzlyxcfOmzjgvb7KDg9
# V/Rh7gfbwVmLcSq52rxdmjkVgj6wHmmJa+SRpze1HyscOeq3INeXL/5enWRg+0sA
# xDqHi1/A/QIDAQABo4IBxTCCAcEwHwYDVR0jBBgwFoAUWsS5eyoKo6XqcQPAYPkt
# 9mV1DlgwHQYDVR0OBBYEFPmQmHiQ5o+PB0RdUhrZboeTlPcZMA4GA1UdDwEB/wQE
# AwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzB3BgNVHR8EcDBuMDWgM6Axhi9odHRw
# Oi8vY3JsMy5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDA1oDOg
# MYYvaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC1jcy1nMS5j
# cmwwTAYDVR0gBEUwQzA3BglghkgBhv1sAwEwKjAoBggrBgEFBQcCARYcaHR0cHM6
# Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAIBgZngQwBBAEwgYQGCCsGAQUFBwEBBHgw
# djAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME4GCCsGAQUF
# BzAChkJodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNz
# dXJlZElEQ29kZVNpZ25pbmdDQS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0B
# AQsFAAOCAQEAXZNMcB8fxisL3Aze8r+ZfxpWm9OBi6r261yBJ1pRVFrlMSH6t4WH
# QgWWajRB1p/nrzPyEqYOX68y+QjFcY+CxZXUpyy2oTzavDBLrYJ1vhtSAg9hO2Z5
# 5DH8mrHg+Ydg+N0k4dlh3Sm0pBXgjVlaVPBnmL+apQhZxyNm+ptqRSyIbzVVyfD6
# lRNYIw4qwN5CvfrRsHcyqQhssV5ehuYaPrfSw8hZMcde5CLgF3cmzYCadyKvx77Z
# tqkO0SbIPcKP3eD8x6GcZiExELtFOLgdof9vaHK8REgUXpU/uuWsXmZ++zAlmdz3
# htUrenG8SQAxqxK2cXXVjFjJiCaGFTbdnDGCBPYwggTyAgEBMIGGMHIxCzAJBgNV
# BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
# Y2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2Rl
# IFNpZ25pbmcgQ0ECEA9jXBtX4FO3yPeXGbuPYtIwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgG8N/Rf5LxT021LFnV8unkKL3vTiqWPAPj+5R7y/mCNkwDQYJKoZIhvcNAQEB
# BQAEggEATbnMf1CYhyqv4sMRWj5VKUcrMWitjnVcsu6Mrcr9qdZOUqbt+vj5K/QR
# sIQBCHn3iYbsedTvtq/w1Jn6EKdtJuVxSdx2mWjC7YQgpx5vO0D0WMqtQXWOzvdx
# Lo+y78PAmF+73OprbaJXHMV37wHelBiYCMIJocGqtUaSFg1WYll8kPSzN93RMyj+
# m824vgtb0Vgp9zKhaXk/sGMJUrO2Er3hkIDcRJX7v8o94jia4gQJ1ue+Zobr+2wH
# xW7wVsTpoWZeLzrEDm93XaP3PRmHxG12UpJoCWk2hDzVq5bKHc4DegtV1tksgiT5
# +vsZcQEOqLaNGSjwv/0RCBN/M9RH9aGCArkwggK1BgkqhkiG9w0BCQYxggKmMIIC
# ogIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJYIZIAWUDBAIBBQCgggEMMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDcwMjIyMDI0MVowLwYJ
# KoZIhvcNAQkEMSIEIAV9CtnOyC9x7+uMiCccNKd6+A2eNED07HK86aDabPp5MIGg
# BgsqhkiG9w0BCRACDDGBkDCBjTCBijCBhwQUPsdm1dTUcuIbHyFDUhwxt5DZS2gw
# bzBfpF0wWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQEFAASCAQBmlRqrwsBBx83oCEB0
# nj+HDM//8b+2+exPs2MBgvjSztPinP5sv1sDarf9dusEEEZByV9VjOYYA1Bg5Y+G
# 5okl/ldtxnj+ZlXzXoJH/PNM+szoGHD6YHgKz8lfFK97jpETVk3d60IFSivxoaj0
# Con1PWZwlGaYZOcb3VUxl+JHXGJ0LuLD2DlCaBnhWMtLo0pUoOKX2iFceoG3116f
# c9Ivh8wBUISw/VfiXgk3ORLxrCGkgw0isBK629ZiRIppC+vnUz2Oulc9fqauyNMi
# cptk5PNTXWSVXmmnAt5lm7CijIcm5GCO8KcdrteEQCZZdlYhTo+GZaXAu+Ye12ed
# Rv3S
# SIG # End signature block
