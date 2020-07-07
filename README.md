# Docker ciscodevnet/ucs-powertool-core
Docker Image for UCS PowerTool Core 3.0.0.10

This docker image contains all required modules to run UCS PowerTool Core for

- Cisco UCS Manager
- Cisco UCS Central
- Cisco IMC

## Using the container

The Container is CentOS 8 based and is running PowerShell Core 7.0.2  Upon launching the container all the Cisco UCS PowerShell Modules are Imported.

`docker pull ciscodevnet/ucs-powertool-core`

`docker run --rm -it ciscodevnet/ucs-powertool-core:latest`

```
➜  ~ docker run --rm -it ciscodevnet/ucs-powertool-core:latest 
PowerShell 7.0.2
Copyright (c) Microsoft Corporation. All rights reserved.

https://aka.ms/powershell
Type 'help' to get help.

          Welcome to Cisco UCS PowerTool Core Suite 3.0.0.10

Log in to UCS Manager:                                                  Connect-Ucs
To generate PowerShell code for UCS Manager use:                        ConvertTo-UcsCmdlet
To show object metadata for UCS PowerTool Cmdlets:                      Get-UcsCmdletMeta

Log in to the IMC of standalone UCS server:                             Connect-Imc
To generate PowerShell code for an IMC of a standalone UCS server:      ConvertTo-ImcCmdlet
To show object metadata for IMC PowerTool Cmdlets:                      Get-ImcCmdletMeta

Log in to UCS Central:                                                  Connect-UcsCentral
To generate PowerShell code for UCS Central use:                        ConvertTo-UcsCentralCmdlet
To show object metadata for UCS Central PowerTool Cmdlets:              Get-UcsCentralCmdletMeta

To display the details of the UCS PowerTool Configuration:              Get-UcsPowerToolConfiguration
To display details of UCS, IMC, and UCS Central active session(s):      Get-UcsPSSession

[UCS PowerTool]: PS /> cd home
[UCS PowerTool]: PS /home>
```

## Default Prompt

The default prompt in the UCS PowerTool Environment is `[UCS PowerTool]: PS /> `

To change the default prompt pass the UCS_PS_1 environment variable when starting the container.

`docker run --rm -it -e UCS_PS_1='US_WEST: ' ciscodevnet/ucs-powertool-core:latest`

```
➜  ~ docker run --rm -it -e UCS_PS_1='US_WEST: ' ciscodevnet/ucs-powertool-core:latest
PowerShell 7.0.2
Copyright (c) Microsoft Corporation. All rights reserved.

https://aka.ms/powershell
Type 'help' to get help.

          Welcome to Cisco UCS PowerTool Core Suite 3.0.0.10

Log in to UCS Manager:                                                  Connect-Ucs
To generate PowerShell code for UCS Manager use:                        ConvertTo-UcsCmdlet
To show object metadata for UCS PowerTool Cmdlets:                      Get-UcsCmdletMeta

Log in to the IMC of standalone UCS server:                             Connect-Imc
To generate PowerShell code for an IMC of a standalone UCS server:      ConvertTo-ImcCmdlet
To show object metadata for IMC PowerTool Cmdlets:                      Get-ImcCmdletMeta

Log in to UCS Central:                                                  Connect-UcsCentral
To generate PowerShell code for UCS Central use:                        ConvertTo-UcsCentralCmdlet
To show object metadata for UCS Central PowerTool Cmdlets:              Get-UcsCentralCmdletMeta

To display the details of the UCS PowerTool Configuration:              Get-UcsPowerToolConfiguration
To display details of UCS, IMC, and UCS Central active session(s):      Get-UcsPSSession

US_WEST: /> cd home 
US_WEST: /home>
```

The current working directory will be reflected in the default prompt and the modified prompt.