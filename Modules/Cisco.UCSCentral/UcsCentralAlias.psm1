Set-Alias Compare-UcsCentralMo Compare-UcsCentralManagedObject
Set-Alias Sync-UcsCentralMo Sync-UcsCentralManagedObject
Set-Alias Get-UcsCentralMo Get-UcsCentralManagedObject
Set-Alias Remove-UcsCentralMo Remove-UcsCentralManagedObject
Set-Alias Add-UcsCentralMo Add-UcsCentralManagedObject
Set-Alias Set-UcsCentralMo Set-UcsCentralManagedObject
Set-Alias Acknowledge-UcsCentralFault Confirm-UcsCentralFault
Set-Alias Get-UcsCentralUcsDomain Get-UcsCentralExtpolClient
Set-Alias Associate-UcsCentralServiceProfile Connect-UcsCentralServiceProfile
Set-Alias Disassociate-UcsCentralServiceProfile Disconnect-UcsCentralServiceProfile
##############################################################################
#.SYNOPSIS
# Remove a Fex
#
#.DESCRIPTION
# Remove a Fex
#
##############################################################################
function FnRemoveUcsCentralFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState remove -Force
	}
	else
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState remove 
	}
}
Set-Alias Remove-UcsCentralFex FnRemoveUcsCentralFex
##############################################################################
#.SYNOPSIS
# Decommission a Fex
#
#.DESCRIPTION
# Decommission a Fex
#
##############################################################################
function FnDecommissionUcsCentralFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState decommission 
	}
}
Set-Alias Decommission-UcsCentralFex FnDecommissionUcsCentralFex
##############################################################################
#.SYNOPSIS
# Recommission a Fex
#
#.DESCRIPTION
# Recommission a Fex
#
##############################################################################
function FnRecommissionUcsCentralFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled 
	}
}
Set-Alias Recommission-UcsCentralFex FnRecommissionUcsCentralFex
##############################################################################
#.SYNOPSIS
# Acknowledge a Fex
#
#.DESCRIPTION
# Acknowledge a Fex
#
##############################################################################
function FnAcknowledgeUcsCentralFex([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsCentralEquipmentFexOperation -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsCentralFex FnAcknowledgeUcsCentralFex
##############################################################################
#.SYNOPSIS
# Decommission a ServerUnit
#
#.DESCRIPTION
# Decommission a ServerUnit
#
##############################################################################
function FnDecommissionUcsCentralServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission 
	}
}
Set-Alias Decommission-UcsCentralServerUnit FnDecommissionUcsCentralServerUnit
##############################################################################
#.SYNOPSIS
# Recommission a ServerUnit
#
#.DESCRIPTION
# Recommission a ServerUnit
#
##############################################################################
function FnRecommissionUcsCentralServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled 
	}
}
Set-Alias Recommission-UcsCentralServerUnit FnRecommissionUcsCentralServerUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a ServerUnit
#
#.DESCRIPTION
# Acknowledge a ServerUnit
#
##############################################################################
function FnAcknowledgeUcsCentralServerUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsCentralServerUnit FnAcknowledgeUcsCentralServerUnit
##############################################################################
#.SYNOPSIS
# Remove a ServerUnit
#
#.DESCRIPTION
# Remove a ServerUnit
#
##############################################################################
function FnRemoveUcsCentralCartridge([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputeCartridgeOperation -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputeCartridgeOperation -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputeCartridgeOperation -Lc remove -Force
	}
	else
	{
		$input | Set-UcsCentralComputeCartridgeOperation -Lc remove 
	}
}
Set-Alias Remove-UcsCentralCartridge FnRemoveUcsCentralCartridge
##############################################################################
#.SYNOPSIS
# Decommission a Chassis
#
#.DESCRIPTION
# Decommission a Chassis
#
##############################################################################
function FnDecommissionUcsCentralChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState decommission -Force
	}
	else
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState decommission 
	}
}
Set-Alias Decommission-UcsCentralChassis FnDecommissionUcsCentralChassis
##############################################################################
#.SYNOPSIS
# Recommission a Chassis
#
#.DESCRIPTION
# Recommission a Chassis
#
##############################################################################
function FnRecommissionUcsCentralChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsCentralFabricSwChPhEpOperation -AdminState enabled 
	}
}
Set-Alias Recommission-UcsCentralChassis FnRecommissionUcsCentralChassis
##############################################################################
#.SYNOPSIS
# Acknowledge a Chassis
#
#.DESCRIPTION
# Acknowledge a Chassis
#
##############################################################################
function FnAcknowledgeUcsCentralChassis([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState re-acknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState re-acknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState re-acknowledge -Force
	}
	else
	{
		$input | Set-UcsCentralEquipmentChassisOperation -AdminState re-acknowledge 
	}
}
Set-Alias Acknowledge-UcsCentralChassis FnAcknowledgeUcsCentralChassis
##############################################################################
#.SYNOPSIS
# Remove a RackUnit
#
#.DESCRIPTION
# Remove a RackUnit
#
##############################################################################
function FnRemoveUcsCentralRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove 
	}
}
Set-Alias Remove-UcsCentralRackUnit FnRemoveUcsCentralRackUnit
##############################################################################
#.SYNOPSIS
# Decommission a RackUnit
#
#.DESCRIPTION
# Decommission a RackUnit
#
##############################################################################
function FnDecommissionUcsCentralRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission 
	}
}
Set-Alias Decommission-UcsCentralRackUnit FnDecommissionUcsCentralRackUnit
##############################################################################
#.SYNOPSIS
# Recommission a RackUnit
#
#.DESCRIPTION
# Recommission a RackUnit
#
##############################################################################
function FnRecommissionUcsCentralRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled 
	}
}
Set-Alias Recommission-UcsCentralRackUnit FnRecommissionUcsCentralRackUnit
##############################################################################
#.SYNOPSIS
# Acknowledge a RackUnit
#
#.DESCRIPTION
# Acknowledge a RackUnit
#
##############################################################################
function FnAcknowledgeUcsCentralRackUnit([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsCentralRackUnit FnAcknowledgeUcsCentralRackUnit
##############################################################################
#.SYNOPSIS
# Decommission a Blade
#
#.DESCRIPTION
# Decommission a Blade
#
##############################################################################
function FnDecommissionUcsCentralBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc decommission 
	}
}
Set-Alias Decommission-UcsCentralBlade FnDecommissionUcsCentralBlade
##############################################################################
#.SYNOPSIS
# Recommission a Blade
#
#.DESCRIPTION
# Recommission a Blade
#
##############################################################################
function FnRecommissionUcsCentralBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled -Force
	}
	else
	{
		$input | Set-UcsCentralFabricComputePhEpOperation -AdminState enabled 
	}
}
Set-Alias Recommission-UcsCentralBlade FnRecommissionUcsCentralBlade
##############################################################################
#.SYNOPSIS
# Acknowledge a Blade
#
#.DESCRIPTION
# Acknowledge a Blade
#
##############################################################################
function FnAcknowledgeUcsCentralBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc rediscover 
	}
}
Set-Alias Acknowledge-UcsCentralBlade FnAcknowledgeUcsCentralBlade
##############################################################################
#.SYNOPSIS
# Remove a Blade
#
#.DESCRIPTION
# Remove a Blade
#
##############################################################################
function FnRemoveUcsCentralBlade([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove -Force
	}
	else
	{
		$input | Set-UcsCentralComputePhysicalOperation -Lc remove 
	}
}
Set-Alias Remove-UcsCentralBlade FnRemoveUcsCentralBlade
##############################################################################
#.SYNOPSIS
# Acknowledge a Slot
#
#.DESCRIPTION
# Acknowledge a Slot
#
##############################################################################
function FnAcknowledgeUcsCentralSlot([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputeSlotEpOperation -AdminState reacknowledge -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-UcsCentralFabricComputeSlotEpOperation -AdminState reacknowledge -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-UcsCentralFabricComputeSlotEpOperation -AdminState reacknowledge -Force
	}
	else
	{
		$input | Set-UcsCentralFabricComputeSlotEpOperation -AdminState reacknowledge 
	}
}
Set-Alias Acknowledge-UcsCentralSlot FnAcknowledgeUcsCentralSlot
Export-ModuleMember -Function * -Alias *

# SIG # Begin signature block
# MIIY7wYJKoZIhvcNAQcCoIIY4DCCGNwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA563WDp5Gy8Uk/
# cUvu2O1nFLkcpTKGh2bPoMi+6YW0kaCCE08wggQVMIIC/aADAgECAgsEAAAAAAEx
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
# IgQgE/K4yMn0lB1Cjyfl8hPKExfRJPqlGNx0jlR/93gVeWcwDQYJKoZIhvcNAQEB
# BQAEggEAoTLXMlP/dAAUkgKMhI72SwvYV+FWMoe1H6Fx9WNAZccRXxlvDARzL6gv
# d/TB5amVLKdMJ6pY7Gl94Lxod246QeCIoQ7f1U1oDVo9G/EDMc0O2dz0fa7qWkgH
# SzxOOy2BTclrVMoId3sct5Uy3kozojAjHosldI36YS06b3jyUdf8Cl9kEAoGtcFn
# ekchptX9eIx03JOLduBIjkz6m1rSpX1r/XrQ2vZGUZ7SVAudGaRf356YsrHT8xWY
# VR/2AIa/jFXE7lHV2Rp9Eu4hAoeb8Q5Jd0uzKsGniVZSfE62GxNVgXQK7Qh2MiIC
# TjxHb414zOZ1+ebqR5t8+G/sbLfy7aGCArkwggK1BgkqhkiG9w0BCQYxggKmMIIC
# ogIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJYIZIAWUDBAIBBQCgggEMMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTIxMjE4NDYyNVowLwYJ
# KoZIhvcNAQkEMSIEIC/hubnlVBXYxkP6E9PUWwkNgUq5MQmfCQE0GWaaj9oxMIGg
# BgsqhkiG9w0BCRACDDGBkDCBjTCBijCBhwQUPsdm1dTUcuIbHyFDUhwxt5DZS2gw
# bzBfpF0wWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQEFAASCAQAr65dSloiq6Xec/4VX
# CMHXVcF8/aTp0uTF+TwDtqYy56G/8DmAMWLtuQWpBSwDefzf/09gZUlRHhLDpen/
# E/1j2UqOe7QltfAjrVPlVgRtbj/3GY2H4DoGJ+1ImZUJmdvtFVzs4BYcMyK6Uh3+
# RTnhuE/GWPa2KXbfVZ8pI29bRUYLB4IqySm+HXg5o+I4pmc06vjAZ/cqXc2g6iSw
# GAObqsEeKzN4Ibr2TditZjIy7G7wZakec+27XABxFmv13CkI1UXt6SBMRvj2V/ch
# yltmR0tqQ0k4yGE7oU/xMJ0XjBp8mzPkeUdYffGqD2jdaL8ORUR7TRxBFOUzVbNx
# OEbU
# SIG # End signature block
