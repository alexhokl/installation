- Open Powershell with administrator privileges.
- Install applications via BoxStarter.

```console
start http://boxstarter.org/package/nr/url?https://gist.githubusercontent.com/alexhokl/70c3a13353baa3955d3efa8b5bdfd0df/raw/4fcf0487be13823888e3e118a581007044fb154f/boxstarter.ps1
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/apm-list.txt", "$pwd\apm-list.txt")
apm install $(cat apm-list.txt)
```

- Configure ReSharper to disallow shadow-copy assemblies for unit tests.
  1. Open Visual Studio.
  2. Open Menu `ReSharper`.
  3. Select `Options`.
  4. In the side menu, select `Tools` and `Unit Testing`.
  5. Un-check `Shadow-copy assemblies being tested`.
- Download and install SQL Data Tools for Visual Studio 2013 (See [Previous releases of SQL Server Data Tools (SSDT and SSDT-BI)](https://msdn.microsoft.com/en-us/library/mt674919.aspx))
- Download and install SQL Server Developer Edition
- Add system enviornment variable `GOPATH` and add `%GOPATH\bin%` to variable `PATH`.
