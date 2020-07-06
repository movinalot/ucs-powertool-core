Set-Alias Get-ImcMo Get-ImcManagedObject
Set-Alias Remove-ImcMo Remove-ImcManagedObject
Set-Alias Add-ImcMo Add-ImcManagedObject
Set-Alias Set-ImcMo Set-ImcManagedObject
##############################################################################
#.SYNOPSIS
# Starts IMC Server
#
#.DESCRIPTION
# Starts IMC Server
#
##############################################################################
function FnStartImcServer([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower up -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcServer -AdminPower up -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower up -Force
	}
	else
	{
		$input | Set-ImcServer -AdminPower up 
	}
}
Set-Alias Start-ImcServer FnStartImcServer
##############################################################################
#.SYNOPSIS
# Stops IMC Server
#
#.DESCRIPTION
# Stops IMC Server
#
##############################################################################
function FnStopImcServer([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower soft-shut-down -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcServer -AdminPower soft-shut-down -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower soft-shut-down -Force
	}
	else
	{
		$input | Set-ImcServer -AdminPower soft-shut-down 
	}
}
Set-Alias Stop-ImcServer FnStopImcServer
##############################################################################
#.SYNOPSIS
# Restarts IMC Server
#
#.DESCRIPTION
# Restarts IMC Server
#
##############################################################################
function FnRestartImcServer([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower cycle-immediate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcServer -AdminPower cycle-immediate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower cycle-immediate -Force
	}
	else
	{
		$input | Set-ImcServer -AdminPower cycle-immediate 
	}
}
Set-Alias Restart-ImcServer FnRestartImcServer
##############################################################################
#.SYNOPSIS
# Resets IMC Server
#
#.DESCRIPTION
# Resets IMC Server
#
##############################################################################
function FnResetImcServer([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower hard-reset-immediate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcServer -AdminPower hard-reset-immediate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcServer -AdminPower hard-reset-immediate -Force
	}
	else
	{
		$input | Set-ImcServer -AdminPower hard-reset-immediate 
	}
}
Set-Alias Reset-ImcServer FnResetImcServer
##############################################################################
#.SYNOPSIS
# Turn on locator LED of rack
#
#.DESCRIPTION
# Turns on the locator LEDs on the front and back of the physical server. You can use the locator LEDs to find this physical server in the rack
#
##############################################################################
function FnEnableImcLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState on -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState on -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState on -Force
	}
	else
	{
		$input | Set-ImcLocatorLed -AdminState on 
	}
}
Set-Alias Enable-ImcLocatorLed FnEnableImcLocatorLed
##############################################################################
#.SYNOPSIS
# Turn off locator LED of rack
#
#.DESCRIPTION
# Turns off the locator LEDs on the front and back of the physical server. You can use the locator LEDs to find this physical server in the rack
#
##############################################################################
function FnDisableImcLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState off -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState off -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcLocatorLed -AdminState off -Force
	}
	else
	{
		$input | Set-ImcLocatorLed -AdminState off 
	}
}
Set-Alias Disable-ImcLocatorLed FnDisableImcLocatorLed
##############################################################################
#.SYNOPSIS
# Runs power characterization
#
#.DESCRIPTION
# Runs a platform characterization stress on the system instantaneously
#
##############################################################################
function FnInvokeImcPowerCharacterization([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction start-power-char -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction start-power-char -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction start-power-char -Force
	}
	else
	{
		$input | Set-ImcPowerBudget -AdminAction start-power-char 
	}
}
Set-Alias Invoke-ImcPowerCharacterization FnInvokeImcPowerCharacterization
##############################################################################
#.SYNOPSIS
# Resets power profile to defaults
#
#.DESCRIPTION
# Resets the power profile configuration to factory default values
#
##############################################################################
function FnResetImcPowerProfile([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction reset-power-profile-default -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction reset-power-profile-default -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcPowerBudget -AdminAction reset-power-profile-default -Force
	}
	else
	{
		$input | Set-ImcPowerBudget -AdminAction reset-power-profile-default 
	}
}
Set-Alias Reset-ImcPowerProfile FnResetImcPowerProfile
##############################################################################
#.SYNOPSIS
# Delete all virtual drives and reset the physical drives
#
#.DESCRIPTION
# Delete all virtual drives and reset the physical drives
#
##############################################################################
function FnResetImcStorageController([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction delete-all-vds-reset-pds -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction delete-all-vds-reset-pds -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction delete-all-vds-reset-pds -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction delete-all-vds-reset-pds 
	}
}
Set-Alias Reset-ImcStorageController FnResetImcStorageController
##############################################################################
#.SYNOPSIS
# Allows you to clear the controller's boot drive
#
#.DESCRIPTION
# Allows you to clear the controller's boot drive
#
##############################################################################
function FnClearImcBootDrive([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-boot-drive -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-boot-drive -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-boot-drive -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction clear-boot-drive 
	}
}
Set-Alias Clear-ImcBootDrive FnClearImcBootDrive
##############################################################################
#.SYNOPSIS
# Allows you to clear the foreign configuration of any physical drives
#
#.DESCRIPTION
# Allows you to clear the foreign configuration of any physical drives
#
##############################################################################
function FnClearImcForeignConfig([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-foreign-config -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-foreign-config -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction clear-foreign-config -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction clear-foreign-config 
	}
}
Set-Alias Clear-ImcForeignConfig FnClearImcForeignConfig
##############################################################################
#.SYNOPSIS
# Allows you to disable JBOD
#
#.DESCRIPTION
# Allows you to disable JBOD
#
##############################################################################
function FnDisableImcJbod([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction disable-jbod -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction disable-jbod -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction disable-jbod -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction disable-jbod 
	}
}
Set-Alias Disable-ImcJbod FnDisableImcJbod
##############################################################################
#.SYNOPSIS
# Exposes both the virtual drives and also the physical drives that are not associated with a virtual drive
#
#.DESCRIPTION
# Exposes both the virtual drives and also the physical drives that are not associated with a virtual drive
#
##############################################################################
function FnEnableImcJbod([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction enable-jbod -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction enable-jbod -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction enable-jbod -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction enable-jbod 
	}
}
Set-Alias Enable-ImcJbod FnEnableImcJbod
##############################################################################
#.SYNOPSIS
# Allows you to retrieve LSI TTY log to Cisco IMC
#
#.DESCRIPTION
# Allows you to retrieve LSI TTY log to Cisco IMC
#
##############################################################################
function FnGetImcTtyLog([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction get-tty-log -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction get-tty-log -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction get-tty-log -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction get-tty-log 
	}
}
Set-Alias Get-ImcTtyLog FnGetImcTtyLog
##############################################################################
#.SYNOPSIS
# Allows you to import the foreign configuration available on the physical drives
#
#.DESCRIPTION
# Allows you to import the foreign configuration available on the physical drives
#
##############################################################################
function FnImportImcForeignConfig([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction import-foreign-config -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction import-foreign-config -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcStorageController -AdminAction import-foreign-config -Force
	}
	else
	{
		$input | Set-ImcStorageController -AdminAction import-foreign-config 
	}
}
Set-Alias Import-ImcForeignConfig FnImportImcForeignConfig
##############################################################################
#.SYNOPSIS
# Reboot CMC of Cisco UCS C3X60 server
#
#.DESCRIPTION
# Reboot CMC of Cisco UCS C3X60 server
#
##############################################################################
function FnResetImcEquipmentSystemIOController([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcequipmentSystemIOController -AdminPower cmc-reboot -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcequipmentSystemIOController -AdminPower cmc-reboot -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcequipmentSystemIOController -AdminPower cmc-reboot -Force
	}
	else
	{
		$input | Set-ImcequipmentSystemIOController -AdminPower cmc-reboot 
	}
}
Set-Alias Reset-ImcEquipmentSystemIOController FnResetImcEquipmentSystemIOController
##############################################################################
#.SYNOPSIS
# Turn on front locator LED of Cisco UCS C3X60 server
#
#.DESCRIPTION
# Turns on the front locator LED of Cisco UCS C3X60 server. You can use the locator LEDs to find this physical server in the rack
#
##############################################################################
function FnEnableImcChassisLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState on -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState on -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState on -Force
	}
	else
	{
		$input | Set-ImcChassisLocatorLed -AdminState on 
	}
}
Set-Alias Enable-ImcChassisLocatorLed FnEnableImcChassisLocatorLed
##############################################################################
#.SYNOPSIS
# Turn off front locator LED of Cisco UCS C3X60 server
#
#.DESCRIPTION
# Turns off the front locator LED of Cisco UCS C3X60 server. You can use the locator LEDs to find this physical server in the rack
#
##############################################################################
function FnDisableImcChassisLocatorLed([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState off -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState off -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcChassisLocatorLed -AdminState off -Force
	}
	else
	{
		$input | Set-ImcChassisLocatorLed -AdminState off 
	}
}
Set-Alias Disable-ImcChassisLocatorLed FnDisableImcChassisLocatorLed
##############################################################################
#.SYNOPSIS
# Reset the platform event filters to default
#
#.DESCRIPTION
# Reset the platform event filters to default
#
##############################################################################
function FnResetImcEventFilters([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcEventManagement -AdminAction reset-event-filters -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcEventManagement -AdminAction reset-event-filters -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcEventManagement -AdminAction reset-event-filters -Force
	}
	else
	{
		$input | Set-ImcEventManagement -AdminAction reset-event-filters 
	}
}
Set-Alias Reset-ImcEventFilters FnResetImcEventFilters
##############################################################################
#.SYNOPSIS
# Delete the LDAP CA certificate present on the Cisco IMC
#
#.DESCRIPTION
# Delete the LDAP CA certificate present on the Cisco IMC
#
##############################################################################
function FnRemoveImcLdapCACertificate([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction delete-ca-certificate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction delete-ca-certificate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction delete-ca-certificate -Force
	}
	else
	{
		$input | Set-ImcLdapCACertificate -AdminAction delete-ca-certificate 
	}
}
Set-Alias Remove-ImcLdapCACertificate FnRemoveImcLdapCACertificate
##############################################################################
#.SYNOPSIS
# Allows you to test the LDAP binding through a generic authentication failure and pam-debug.log file. This file contains the output where the binding steps are described in detail. You must enable the 'debug' mode in the Pluggable Authentication Module (PAM) to generate and view the pam-debug.log file.
#
#.DESCRIPTION
# Allows you to test the LDAP binding through a generic authentication failure and pam-debug.log file. This file contains the output where the binding steps are described in detail. You must enable the 'debug' mode in the Pluggable Authentication Module (PAM) to generate and view the pam-debug.log file.
#
##############################################################################
function FnTestImcLdapBinding([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction test-ldap-binding -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction test-ldap-binding -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcLdapCACertificate -AdminAction test-ldap-binding -Force
	}
	else
	{
		$input | Set-ImcLdapCACertificate -AdminAction test-ldap-binding 
	}
}
Set-Alias Test-ImcLdapBinding FnTestImcLdapBinding
##############################################################################
#.SYNOPSIS
# Activates the specified PID catalog in Cisco IMC.
#
#.DESCRIPTION
# Activates the specified PID catalog in Cisco IMC.
#
##############################################################################
function FnEnableImcPidCatalog([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcActivatePIDCatalog -AdminState trigger -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcActivatePIDCatalog -AdminState trigger -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcActivatePIDCatalog -AdminState trigger -Force
	}
	else
	{
		$input | Set-ImcActivatePIDCatalog -AdminState trigger 
	}
}
Set-Alias Enable-ImcPidCatalog FnEnableImcPidCatalog
##############################################################################
#.SYNOPSIS
# Activates the specified BIOS profile.
#
#.DESCRIPTION
# Activates the specified BIOS profile.
#
##############################################################################
function FnEnableImcBiosProfile([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction activate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction activate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction activate -Force
	}
	else
	{
		$input | Set-ImcBiosProfile -AdminAction activate 
	}
}
Set-Alias Enable-ImcBiosProfile FnEnableImcBiosProfile
##############################################################################
#.SYNOPSIS
# Deletes the specified BIOS profile.
#
#.DESCRIPTION
# Deletes the specified PID catalog in Cisco IMC.
#
##############################################################################
function FnRemoveImcBiosProfile([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction delete -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction delete -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcBiosProfile -AdminAction delete -Force
	}
	else
	{
		$input | Set-ImcBiosProfile -AdminAction delete 
	}
}
Set-Alias Remove-ImcBiosProfile FnRemoveImcBiosProfile
##############################################################################
#.SYNOPSIS
# Allows you to take a backup of the BIOS configuration by deleting the existing BIOS profile and creating a new one if backup exists, else creates a new backup file.
#
#.DESCRIPTION
# Allows you to take a backup of the BIOS configuration by deleting the existing BIOS profile and creating a new one if backup exists, else creates a new backup file. You can activate the backed up BIOS profile any time to go back to the previous configuration.
#
##############################################################################
function FnBackupImcBiosProfile([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcBiosProfileManagement -AdminAction backup -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcBiosProfileManagement -AdminAction backup -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcBiosProfileManagement -AdminAction backup -Force
	}
	else
	{
		$input | Set-ImcBiosProfileManagement -AdminAction backup 
	}
}
Set-Alias Backup-ImcBiosProfile FnBackupImcBiosProfile
##############################################################################
#.SYNOPSIS
# Clears the one time precision boot device in Cisco IMC.
#
#.DESCRIPTION
# Clears the one time precision boot device in Cisco IMC.
#
##############################################################################
function FnClearImcOneTimePrecisionBootDevice([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcOneTimePrecisionBootDevice -AdminAction clear-one-time-boot-device -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcOneTimePrecisionBootDevice -AdminAction clear-one-time-boot-device -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcOneTimePrecisionBootDevice -AdminAction clear-one-time-boot-device -Force
	}
	else
	{
		$input | Set-ImcOneTimePrecisionBootDevice -AdminAction clear-one-time-boot-device 
	}
}
Set-Alias Clear-ImcOneTimePrecisionBootDevice FnClearImcOneTimePrecisionBootDevice
##############################################################################
#.SYNOPSIS
# This allows you to delete the root CA certificate.
#
#.DESCRIPTION
# This allows you to delete the root CA certificate in Cisco IMC.
#
##############################################################################
function FnRemoveImcRootCACertificate([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-root-ca-certificate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-root-ca-certificate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-root-ca-certificate -Force
	}
	else
	{
		$input | Set-ImcKmipManagement -AdminAction delete-root-ca-certificate 
	}
}
Set-Alias Remove-ImcRootCACertificate FnRemoveImcRootCACertificate
##############################################################################
#.SYNOPSIS
# This allows you to delete the client certificate.
#
#.DESCRIPTION
# This allows you to delete the client certificate in Cisco IMC.
#
##############################################################################
function FnRemoveImcClientCertificate([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-certificate -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-certificate -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-certificate -Force
	}
	else
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-certificate 
	}
}
Set-Alias Remove-ImcClientCertificate FnRemoveImcClientCertificate
##############################################################################
#.SYNOPSIS
# This allows you to delete the client private key
#
#.DESCRIPTION
# This allows you to delete the client private key in Cisco IMC.
#
##############################################################################
function FnRemoveImcClientPrivateKey([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-private-key -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-private-key -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-private-key -Force
	}
	else
	{
		$input | Set-ImcKmipManagement -AdminAction delete-client-private-key 
	}
}
Set-Alias Remove-ImcClientPrivateKey FnRemoveImcClientPrivateKey
##############################################################################
#.SYNOPSIS
# This allows you to delete the KMIP login details.
#
#.DESCRIPTION
# This allows you to delete the KMIP login details.
#
##############################################################################
function FnClearImcKmipLogin([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcKmipServerLogin -AdminAction clear -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcKmipServerLogin -AdminAction clear -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcKmipServerLogin -AdminAction clear -Force
	}
	else
	{
		$input | Set-ImcKmipServerLogin -AdminAction clear 
	}
}
Set-Alias Clear-ImcKmipLogin FnClearImcKmipLogin
##############################################################################
#.SYNOPSIS
# This allows you to clear the KMIP server details.
#
#.DESCRIPTION
# This allows you to clear the KMIP server details.
#
##############################################################################
function FnClearImcKmipServer([switch]$Xml, [switch]$Force)
{
	if($Xml.IsPresent -and $Force.IsPresent)
	{
		$input | Set-ImcKmipServer   -AdminAction delete -Xml -Force
	}
	elseif($Xml.IsPresent)
	{
		$input | Set-ImcKmipServer   -AdminAction delete -Xml
	}
	elseif($Force.IsPresent)
	{
		$input | Set-ImcKmipServer   -AdminAction delete -Force
	}
	else
	{
		$input | Set-ImcKmipServer   -AdminAction delete 
	}
}
Set-Alias Clear-ImcKmipServer FnClearImcKmipServer
Set-Alias Acknowledge-ImcFault Confirm-ImcFault
Export-ModuleMember -Function * -Alias *

# SIG # Begin signature block
# MIIY7wYJKoZIhvcNAQcCoIIY4DCCGNwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBURHvUN/63fC2B
# cEvWQbo2Yz+nod3re82ktOBKtTiPwaCCE08wggQVMIIC/aADAgECAgsEAAAAAAEx
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
# IgQgXguiLJwOsdndmnxkJJUvP6MIZV7o+MbLYvKp72dqVPMwDQYJKoZIhvcNAQEB
# BQAEggEAKv8QH+4DAUA/+Kpog2spikeTiunkrQodb8HO+U5eHVsskV+1Jrv7t0Y8
# CdHWpzcX87SnE1R4zX6pqMVwbL3sD6N3v6fjBy72rfbKYQyiuJSz/TIsxMpGEZWG
# IFkjTAQeBB2SAt1YRVI3cOCTM6mUQ4azvuNcDYxqJwbRT//bjcul/8yzh1f02oXg
# YKsZILk43v2qxL+H5kVh/JfkyoLHFB7ujqKWg6lzj9Z+FM9yU/cdBikdYVQhapdQ
# bo7LdrerwKyEFoAbj69VguvNscPB00NKQ2lVqgn2gO6OvxnHHmrEgJjHKElV/kz0
# QMw1az4mnXCXwcpgSEoI61MQVkJhM6GCArkwggK1BgkqhkiG9w0BCQYxggKmMIIC
# ogIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJYIZIAWUDBAIBBQCgggEMMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDcwMjIyMDIzOVowLwYJ
# KoZIhvcNAQkEMSIEII9nN7cnh5SV3fny3qk3xdMk+lYYVNk0MOiFeMA3TtkcMIGg
# BgsqhkiG9w0BCRACDDGBkDCBjTCBijCBhwQUPsdm1dTUcuIbHyFDUhwxt5DZS2gw
# bzBfpF0wWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQEFAASCAQAY1cB7kuNv+sWhk1le
# ++PWGJRTWDZq50q5P6CsHHsT0JA1WKkFpJVMLNxO9is0ByWDLHDAsKR7cwCorTKd
# Sru18gkHF8JBm7elu9vw68g610/00AFoLBoQXD6o5ftJwIYXQIK+VEfPBPyQQHab
# jhTBHWXs/UygHeP9kzn2cOwaisOklh+qdBRJpeggIyflzjjluI99qY2DSkyIR6af
# mcMnQmklfOjCv0JwdFOmGo7k8IlSXTUZpTOE65DZKsytr5nuN3zfc7ZCcOWWFLI0
# DQJ6qm0eII4waTEe6Z6gWnNqFug2Nd0pr6lTiNsxAMFqCMlOQPEoXTSM+UQQvC2h
# OD9A
# SIG # End signature block
