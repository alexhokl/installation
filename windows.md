- Open command prompt with administrator privilege.
- Install Chocolatey by running the following command.
```console
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
- Exit the command prompt.
- Open Powershell with administrator privilege.
- Execute the following command to download a list of installations (see [list](https://github.com/alexhokl/installation/blob/master/choco-list.config)).
```console
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/alexhokl/installation/master/choco-list.config', 'choco-list.config')
```
- Install the list by executing the following command.
```console
choco install -y choco-list.config
```
- Configure ReSharper to disallow shadow-copy assemblies for unit tests.
  1. Open Visual Studio.
  2. Open Menu `ReSharper`.
  3. Select `Options`.
  4. In the side menu, select `Tools` and `Unit Testing`.
  5. Un-check `Shadow-copy assemblies being tested`.
- Download and install SQL Data Tools for Visual Studio 2013 (See [Previous releases of SQL Server Data Tools (SSDT and SSDT-BI)](https://msdn.microsoft.com/en-us/library/mt674919.aspx))
- Download and install SQL Server Developer Edition
- Download and install Docker for Windows (beta) (See [Download Docker for
  Windows](https://docs.docker.com/docker-for-windows/))
- Download and install [GitHub for Windows](https://desktop.github.com/)
- Add system enviornment variable `GOPATH` and add `%GOPATH\bin%` to variable
  `PATH`.
