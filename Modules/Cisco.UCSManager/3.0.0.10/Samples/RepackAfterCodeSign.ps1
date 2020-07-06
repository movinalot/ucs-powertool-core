param(
[string] $AfterCodeSignFilePath,
[switch] $PowerToolCore
)

$IMCFileList = @("Cisco.Imc.Cmdlets.dll",
                    "Cisco.Imc.Cmdlets.dll-help.xml",
                    "Cisco.Imc.dll",
                    "Cisco.IMC.psd1",
                    "ImcAlias.psm1",
                    "StartImcPS.ps1")
$CoreFileList = @("CcoImageMeta.xml",
                    "Cisco.Ucs.Common.Cmdlets.dll",
                    "Cisco.Ucs.Common.Cmdlets.dll-help.xml",
                    "Cisco.Ucs.Common.dll",
                    "Cisco.UCS.Common.psd1",
                    "CoreAlias.psm1",
                    "UcsHclToolMeta.xml")

$CentralFileList = @("Cisco.UcsCentral.Cmdlets.dll",
                        "Cisco.UcsCentral.Cmdlets.dll-help.xml",
                        "Cisco.UcsCentral.dll",
                        "Cisco.UCSCentral.psd1",
                        "UcsCentralAlias.psm1",
                        "StartUcsCentralPS.ps1")

$UcsmFileList = @("Cisco.Ucsm.Cmdlets.dll",
                    "Cisco.Ucsm.Cmdlets.dll-help.xml",
                    "Cisco.Ucsm.dll",
                    "Cisco.UCSManager.psd1",
                    "UcsAlias.psm1",
                    "StartUcsPS.ps1")

$SampleFileList = @(
                    "Export-UcsMoXml.ps1",
                    "Get-UcsCimcIpReport.ps1",
                    "Get-UcsDvsConfig.ps1",
                    "Get-UcsGlobalPolicy.ps1",
                    "Import-UcsMoXml.ps1",
                    "Install-UcsAll.ps1")

$SignatureNotRequiredFiles = @(".xml",".mof")

if($AfterCodeSignFilePath -eq $Null)
{
    $AfterCodeSignFilePath = Read-Host "Enter the file AfterCodeSignFilePath"
}

if($AfterCodeSignFilePath -ne $Null -and !(Test-Path -Path $AfterCodeSignFilePath))
{
  throw "Inavlid file path $AfterCodeSignFilePath"
}

$FileList = Get-ChildItem -Path $AfterCodeSignFilePath

foreach($item in $FileList)
{
    Unblock-File -Path $item.FullName -Verbose

    if($SignatureNotRequiredFiles -notcontains $item.Extension)
    {
        $signedStatus = Get-AuthenticodeSignature -FilePath $item.FullName
        if($signedStatus.Status -ne "Valid")
        {
            throw "Invalid Signature for file $($signedStatus.Path)"

        }
        Write-Host "$($signedStatus.Path) ------------> $($signedStatus.Status)" -BackgroundColor Green
    }
}

$AfterCodeSignFilePathFileInfo = Get-Item -Path $AfterCodeSignFilePath

if($PowerToolCore)
{
    $tempPath = Join-Path -Path $AfterCodeSignFilePathFileInfo.Parent.FullName -ChildPath "UCSPowerToolCore"
}
else
{
    $tempPath = Join-Path -Path $AfterCodeSignFilePathFileInfo.Parent.FullName -ChildPath "PowerToolSuite"
}

$PackageFolder = New-Item -Path $tempPath -ItemType Directory

#Create all the required folder
Write-Host "Creating directory Cisco.IMC"
$IMCFolderName = Join-Path -Path $PackageFolder.FullName -ChildPath "Cisco.IMC"
$IMCFolder = New-Item -Path $IMCFolderName -ItemType Directory

Write-Host "Creating directory Cisco.UCS.Common"
$CommonFolderName = Join-Path -Path $PackageFolder.FullName -ChildPath "Cisco.UCS.Common"
$CommonFolder = New-Item -Path $CommonFolderName -ItemType Directory

Write-Host "Creating directory Cisco.UCSCentral"
$CentralFolderName = Join-Path -Path $PackageFolder.FullName -ChildPath "Cisco.UCSCentral"
$CentralFolder = New-Item -Path $CentralFolderName -ItemType Directory

Write-Host "Creating directory Cisco.UcsManager"
$UcsmFolderName = Join-Path -Path $PackageFolder.FullName -ChildPath "Cisco.UCSManager"
$UcsmFolder = New-Item -Path $UcsmFolderName -ItemType Directory

Write-Host "Creating directory Cisco.UcsManager"
$SampleFolderName = Join-Path -Path $UcsmFolder.FullName -ChildPath "Samples"
$SampleFolder = New-Item -Path $SampleFolderName -ItemType Directory


foreach($item in $FileList)
{

    if($item.Name -eq "Start-UcsPowerTool.ps1")
    {
        Write-Host "copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $PackageFolder.FullName
    }

    if($IMCFileList -contains $item.Name)
    {
        Write-Host "IMC -------> copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $IMCFolder.FullName
    }

    if($CoreFileList -contains $item.Name)

    {
        Write-Host "Core -------> copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $CommonFolder.FullName
    }

    if($CentralFileList -contains $item.Name)
    {
        Write-Host "Central -------> copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $CentralFolder.FullName
    }

    if($UcsmFileList -contains $item.Name)
    {
        Write-Host "Ucsm -------> copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $UcsmFolder.FullName
    }

    if($SampleFileList -contains $item.Name)
    {
        Write-Host "Samples -----------------> copying file $($item.Name)"
        Copy-Item -Path $item.FullName -Destination $SampleFolder.FullName
    }

}
