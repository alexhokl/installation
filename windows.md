1. Open command prompt with administrator privilege.
2. Install Chocolatey by running the following command.
```console
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
3. Exit the command prompt. 
4. Open Powershell with administrator privilege.
5. Execute the following command to download a list of installations.
```console
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/alexhokl/installation/master/choco-list.config', 'choco-list.config')
```
6. Install the list by executing the following command.
```console
choco install -y choco-list.config
```
7. Download and install SQL Server Developer Edition
8. Download and install Docker for Windows
9. Download and install GitHub for Windows
