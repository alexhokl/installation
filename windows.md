- Open Powershell with administrator privileges.
- See boxstarter script on [gist](https://gist.github.com/alexhokl/70c3a13353baa3955d3efa8b5bdfd0df)

```console
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots
code --install-extension ms-mssql.mssql
code --install-extension dbaeumer.vscode-eslint
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.Go
code --install-extension ms-python.python
code --install-extension PeterJausovec.vscode-docker
code --install-extension ms-vscode.PowerShell
code --install-extension Zignd.html-css-class-completion
code --install-extension redhat.vscode-yaml
code --install-extension robinbentley.sass-indented
```

- Configure ReSharper to disallow shadow-copy assemblies for unit tests.
  1. Open Visual Studio.
  2. Open Menu `ReSharper`.
  3. Select `Options`.
  4. In the side menu, select `Tools` and `Unit Testing`.
  5. Un-check `Shadow-copy assemblies being tested`.
- Add system enviornment variable `GOPATH` and add `%GOPATH\bin%` to variable `PATH`.
