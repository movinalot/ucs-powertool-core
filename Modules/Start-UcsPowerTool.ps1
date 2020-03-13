Import-Module Cisco.UCS.Core
Import-Module Cisco.UCSManager
Import-Module Cisco.UCSCentral
Import-Module Cisco.IMC
$version = Get-UcsPowerToolConfiguration
write-host "          Welcome to Cisco UCS PowerTool Core Suite $($version.Version) Beta"
write-host ""
write-host "Log in to a UCS Manager Domain:                                         " -NoNewLine
write-host "Connect-Ucs" -foregroundcolor yellow
write-host "To generate PowerShell code from a running UCS Manager GUI:             " -NoNewLine
write-host "ConvertTo-UcsCmdlet" -foregroundcolor yellow
write-host "To show object metadata for all UCS PowerTool commands:                 " -NoNewLine
write-host "Get-UcsCmdletMeta" -foregroundcolor yellow  
write-host ""
write-host "Log in to an IMC of standalone UCS server:                              " -NoNewLine
write-host "Connect-Imc" -foregroundcolor yellow
write-host "Generate PowerShell code from a running IMC of standalone UCS server:   " -NoNewLine
write-host "ConvertTo-ImcCmdlet" -foregroundcolor yellow
write-host "Show object metadata for all IMC PowerTool cmdlets:                     " -NoNewLine
write-host "Get-ImcCmdletMeta" -foregroundcolor yellow  
write-host ""
write-host "Log in to a UCS Central server:                                         " -NoNewLine
write-host "Connect-UcsCentral" -foregroundcolor yellow
write-host "To generate PowerShell code from a running UCS Central GUI:             " -NoNewLine
write-host "ConvertTo-UcsCentralCmdlet" -foregroundcolor yellow
write-host "To show object metadata for all UCS Central PowerTool commands:         " -NoNewLine
write-host "Get-UcsCentralCmdletMeta" -foregroundcolor yellow  
write-host "Once you've connected, display the details of active session(s):        " -NoNewLine
write-host "Get-UcsPSSession" -foregroundcolor yellow
write-host ""
write-host "If you need more help, visit the UCS PowerTool user community:          " -NoNewLine
write-host "https://communities.cisco.com/ucsintegrations" -foregroundcolor yellow
write-host ""