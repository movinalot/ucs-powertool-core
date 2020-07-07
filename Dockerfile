FROM centos:latest
LABEL Maintainer="John McDonough @movinalot" Name=ucs-powertool-core Version=3.0.0.10
RUN yum -y install curl
RUN curl -s https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/microsoft.repo
RUN yum -y install powershell
COPY Modules/ /root/.local/share/powershell/Modules/
CMD ["pwsh", "-NoExit", "-File", "/root/.local/share/powershell/Modules/Start-UcsPowerTool.ps1"]
