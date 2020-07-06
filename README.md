# docker-ucs-powertool-core
Docker Image for UCS PowerTool Core 3.0.0.10

This docker image contains all required modules to run UCS PowerTool Core for

- Cisco UCS Manager
- Cisco UCS Central
- Cisco IMC

## Using the container

The Container is CentOS 8 based and is running PowerShell Core 7.0.2  Upon launching the container all the Cisco UCS PowerShell Modules are Imported.

`docker pull ciscodevnet/ucs-powertool-core`

`docker run --rm -it  ciscodevnet/ucs-powertool-core:latest`