- Open command prompt with administrator privilege.
- Install Chocolatey by running the following command.
```console
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
- Exit the command prompt. 
- Open Powershell with administrator privilege.
- Execute the following command to download a list of installations.
```console
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/alexhokl/installation/master/choco-list.config', 'choco-list.config')
```
- Install the list by executing the following command.
```console
choco install -y choco-list.config
```
- Download and install SQL Server Developer Edition
- Download and install Docker for Windows
- Download and install GitHub for Windows
