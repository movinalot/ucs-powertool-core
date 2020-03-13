# docker-ucs-powertool-core
Docker Image for UCS PowerTool Core

This docker image contains all required packages to run UCS PowerTool Core against;

- Cisco UCS MAnager
- Cisco UCS Central
- Cisco IMC

Using the container

The Container is CentOS based and is running PowerShell Core 7.0.  Upon launching the container all the Cisco UCS PowerShell Modules are Imported.

`docker pull ciscodevnet/ucs-powertool-core`

`docker run --rm -it  ciscodevnet/ucs-powertool-core:latest`