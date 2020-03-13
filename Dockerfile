FROM centos:latest
LABEL Maintaner="John McDonough @movinalot" Name=ucspowertool Version=0.0.2
RUN yum -y install curl
RUN curl -s https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/microsoft.repo
RUN yum -y install powershell
RUN pwsh
COPY Modules/ /root/.local/share/powershell/Modules/
CMD ["pwsh", "-NoExit", "-File", "/root/.local/share/powershell/Modules/Start-UcsPowerTool.ps1"]
