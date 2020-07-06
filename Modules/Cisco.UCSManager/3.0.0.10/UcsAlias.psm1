Set-Alias Compare-UcsMo Compare-UcsManagedObject
Set-Alias Get-UcsMo Get-UcsManagedObject
Set-Alias Remove-UcsMo Remove-UcsManagedObject
Set-Alias Add-UcsMo Add-UcsManagedObject
Set-Alias Set-UcsMo Set-UcsManagedObject
Set-Alias Sync-UcsMo Sync-UcsManagedObject
Set-Alias Unregister-UcsCentral Remove-UcsPolicyControlEp
Set-Alias Get-UcsCentral Get-UcsPolicyControlEp
Set-Alias Associate-UcsServiceProfile Connect-UcsServiceProfile
Set-Alias Disassociate-UcsServiceProfile Disconnect-UcsServiceProfile
Set-Alias Acknowledge-UcsFault Confirm-UcsFault
##############################################################################
#.SYNOPSIS
# Remove a Blade
#
#.DESCRIPTION
# Remove a Blade
#
##############################################################################
function FnRemoveUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc remove -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc remove 
	}
}
Set-Alias Remove-UcsBlade FnRemoveUcsBlade
##############################################################################
#.SYNOPSIS
# Decommission a Blade
#
#.DESCRIPTION
# Decommission a Blade
#
##############################################################################
function FnDecommissionUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc decommission 
	}
}
Set-Alias Decommission-UcsBlade FnDecommissionUcsBlade
##############################################################################
#.SYNOPSIS
# Recommission a Blade
#
#.DESCRIPTION
# Recommission a Blade
#
##############################################################################
function FnRecommissionUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsBlade FnRecommissionUcsBlade
##############################################################################
#.SYNOPSIS
# Acknowledge a Blade
#
#.DESCRIPTION
# Acknowledge a Blade
#
##############################################################################
function FnAcknowledgeUcsBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsBlade -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsBlade -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsBlade FnAcknowledgeUcsBlade
##############################################################################
#.SYNOPSIS
# Remove a Chassis
#
#.DESCRIPTION
# Remove a Chassis
#
##############################################################################
function FnRemoveUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState remove -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState remove 
	}
}
Set-Alias Remove-UcsChassis FnRemoveUcsChassis
##############################################################################
#.SYNOPSIS
# Decommission a Chassis
#
#.DESCRIPTION
# Decommission a Chassis
#
##############################################################################
function FnDecommissionUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState decommission 
	}
}
Set-Alias Decommission-UcsChassis FnDecommissionUcsChassis
##############################################################################
#.SYNOPSIS
# Recommission a Chassis
#
#.DESCRIPTION
# Recommission a Chassis
#
##############################################################################
function FnRecommissionUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsChassis FnRecommissionUcsChassis
##############################################################################
#.SYNOPSIS
# Acknowledge a Chassis
#
#.DESCRIPTION
# Acknowledge a Chassis
#
##############################################################################
function FnAcknowledgeUcsChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsChassis -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsChassis -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsChassis FnAcknowledgeUcsChassis
##############################################################################
#.SYNOPSIS
# Remove a Fex
#
#.DESCRIPTION
# Remove a Fex
#
##############################################################################
function FnRemoveUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState remove -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState remove 
	}
}
Set-Alias Remove-UcsFex FnRemoveUcsFex
##############################################################################
#.SYNOPSIS
# Decommission a Fex
#
#.DESCRIPTION
# Decommission a Fex
#
##############################################################################
function FnDecommissionUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState decommission 
	}
}
Set-Alias Decommission-UcsFex FnDecommissionUcsFex
##############################################################################
#.SYNOPSIS
# Recommission a Fex
#
#.DESCRIPTION
# Recommission a Fex
#
##############################################################################
function FnRecommissionUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricSwChPhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsFex FnRecommissionUcsFex
##############################################################################
#.SYNOPSIS
# Acknowledge a Fex
#
#.DESCRIPTION
# Acknowledge a Fex
#
##############################################################################
function FnAcknowledgeUcsFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFex -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsFex -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsFex FnAcknowledgeUcsFex
##############################################################################
#.SYNOPSIS
# Acknowledge a Slot
#
#.DESCRIPTION
# Acknowledge a Slot
#
##############################################################################
function FnAcknowledgeUcsSlot([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge -Force
	}
	else
	{
		$input | Set-UcsFabricComputeSlotEp -AdminState reacknowledge 
	}
}
Set-Alias Acknowledge-UcsSlot FnAcknowledgeUcsSlot
##############################################################################
#.SYNOPSIS
# Remove a RackUnit
#
#.DESCRIPTION
# Remove a RackUnit
#
##############################################################################
function FnRemoveUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc remove -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc remove 
	}
}
Set-Alias Remove-UcsRackUnit FnRemoveUcsRackUnit
##############################################################################
#.SYNOPSIS
# Decommission a RackUnit
#
#.DESCRIPTION
# Decommission a RackUnit
#
##############################################################################
function FnDecommissionUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc decommission 
	}
}
Set-Alias Decommission-UcsRackUnit FnDecommissionUcsRackUnit
##############################################################################
#.SYNOPSIS
# Recommission a RackUnit
#
#.DESCRIPTION
# Recommission a RackUnit
#
##############################################################################
function FnRecommissionUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsFabricComputePhEp -AdminState enabled 
	}
}
Set-Alias Recommission-UcsRackUnit FnRecommissionUcsRackUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a RackUnit
#
#.DESCRIPTION
# Acknowledge a RackUnit
#
##############################################################################
function FnAcknowledgeUcsRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsRackUnit -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsRackUnit -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsRackUnit FnAcknowledgeUcsRackUnit
##############################################################################
#.SYNOPSIS
# Remove a ServerUnit
#
#.DESCRIPTION
# Remove a ServerUnit
#
##############################################################################
function FnRemoveUcsCartridge([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCartridge -Lc remove -Force
	}
	else
	{
		$input | Set-UcsCartridge -Lc remove 
	}
}
Set-Alias Remove-UcsCartridge FnRemoveUcsCartridge
##############################################################################
#.SYNOPSIS
# Decommission a ServerUnit
#
#.DESCRIPTION
# Decommission a ServerUnit
#
##############################################################################
function FnDecommissionUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsServerUnit -Lc decommission 
	}
}
Set-Alias Decommission-UcsServerUnit FnDecommissionUcsServerUnit
##############################################################################
#.SYNOPSIS
# Recommission a ServerUnit
#
#.DESCRIPTION
# Recommission a ServerUnit
#
##############################################################################
function FnRecommissionUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge -Force
	}
	else
	{
		$input | Set-UcsFabricComputeMSlotEp  -SlotAdminState reacknowledge 
	}
}
Set-Alias Recommission-UcsServerUnit FnRecommissionUcsServerUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a ServerUnit
#
#.DESCRIPTION
# Acknowledge a ServerUnit
#
##############################################################################
function FnAcknowledgeUcsServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsServerUnit -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsServerUnit -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsServerUnit FnAcknowledgeUcsServerUnit
##############################################################################
#.SYNOPSIS
# Reset IO Module
#
#.DESCRIPTION
# Reset IO Module
#
##############################################################################
function FnResetUcsIoModule([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy -Force
	}
	else
	{
		$input | Set-UcsIom -AdminPowerState cycle-immediate -AdminState acknowledged -AdminPeerPowerState policy 
	}
}
Set-Alias Reset-UcsIoModule FnResetUcsIoModule
##############################################################################
#.SYNOPSIS
# Reset Peer IO Module
#
#.DESCRIPTION
# Reset Peer IO Module
#
##############################################################################
function FnResetUcsPeerIoModule([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate -Force
	}
	else
	{
		$input | Set-UcsIom -AdminPowerState policy -AdminState acknowledged -AdminPeerPowerState cycle-immediate 
	}
}
Set-Alias Reset-UcsPeerIoModule FnResetUcsPeerIoModule
##############################################################################
#.SYNOPSIS
# Turn On Disk Locator LED
#
#.DESCRIPTION
# Turn On Disk Locator LED
#
##############################################################################
function FnEnableUcsDiskLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on -Force
	}
	else
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-on 
	}
}
Set-Alias Enable-UcsDiskLocatorLed FnEnableUcsDiskLocatorLed
##############################################################################
#.SYNOPSIS
# Turn Off Disk Locator LED
#
#.DESCRIPTION
# Turn Off Disk Locator LED
#
##############################################################################
function FnDisableUcsDiskLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off -Force
	}
	else
	{
		$input | Set-UcsStorageLocalDisk -AdminActionTrigger triggered -AdminAction led-off 
	}
}
Set-Alias Disable-UcsDiskLocatorLed FnDisableUcsDiskLocatorLed
Export-ModuleMember -Function * -Alias *

# SIG # Begin signature block
# MIIY7wYJKoZIhvcNAQcCoIIY4DCCGNwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDtdoqOPMCJ8ZRu
# CdKNH0RB2JXNlR4hMjgTc2n7rC4t1KCCE08wggQVMIIC/aADAgECAgsEAAAAAAEx
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
# IgQgh9HjpLj6kK05CuAwaRkgyX6dOuBLVhK4J1a391/puzIwDQYJKoZIhvcNAQEB
# BQAEggEARIKERfvpkCO6kOHd0m1uc8/aUHhSuAyTfeosA44EFt2kkYhLREBPczTJ
# cWqezWFA4urnlCjsW4Py204iMGvepzW3J9j/YeT1mtOnxOYp4gCZTlDk6TsGGkBY
# CDIS7hcK6Ye92w5DM5XRIR1o78d+JjOB5eDXUMlyjqzTFjhOrCtlMjKjYNTKMeDP
# RHRDdxL5X+95M6ILU/R1hd1wgv5TjakhBEEMwrA89A84YNc5nXGSyfErbhvdenDY
# UrqU2C36ZmaSKLYzv7ykWr2FEkY93PDgNDooJ/N5/tbCpXc4eIzyoPpZ1OvsKVoF
# NPWi4HNeq3wk6NVWmMj67xQVmved/aGCArkwggK1BgkqhkiG9w0BCQYxggKmMIIC
# ogIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJYIZIAWUDBAIBBQCgggEMMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDcwMjIyMDI0MFowLwYJ
# KoZIhvcNAQkEMSIEIM292BKbOsfzqCJ9Xtw+rsoGM4dGmrh1v3HNCRl2v5b+MIGg
# BgsqhkiG9w0BCRACDDGBkDCBjTCBijCBhwQUPsdm1dTUcuIbHyFDUhwxt5DZS2gw
# bzBfpF0wWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQEFAASCAQDO0DBJ90hMVwJ4Nbd4
# mdFTohCmBQ2GKcyMjijA59m2j1QsMJ8cCa1as3tIgWT0wBFCguMdTwqgJZp7LB6J
# e1Da+jfgq10NteDdRJnGYTGR2ukK+kaVoDzOrpR/0vHgRodPAMk6MwKgnax/a4Wl
# vSfCrn/9zbu8zxrdmmSvcb8PwljoDQlM+G8i8DpwLGIcCqFEZmI1XO3v5LUqepjT
# cExYF2Hb4aGMxeONHYU8yzIghhKcCOEG8ejlbXBFDZdeDoGQ5Chij0GuxqAEKLEd
# EUtWtPIOPDXjAHUrZvJyIo5OC2uUW3/F4o4cv8FhOpiglzRjeOhpYiTeCBaf55uX
# tFfb
# SIG # End signature block
