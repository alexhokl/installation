- Open Powershell with administrator privileges.
- See boxstarter script on [gist](https://gist.github.com/alexhokl/70c3a13353baa3955d3efa8b5bdfd0df)

```console
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots
npm i -g iisexpress-proxy
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
pip install awscli --upgrade --user
$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$newPath=$oldPath+";C:\Users\alex\Desktop\git\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name GOPATH –Value "C:\Users\alex\Desktop\git"
```

- Reboot to prepare .NET Framework installation

```console
choco install -y netfx-4.7.2-devpack
```

- Configure ReSharper to disallow shadow-copy assemblies for unit tests.
  1. Open Visual Studio.
  2. Open Menu `ReSharper`.
  3. Select `Options`.
  4. In the side menu, select `Tools` and `Unit Testing`.
  5. Un-check `Shadow-copy assemblies being tested`.

```console
mkdir .\Desktop\git
go get -u github.com/alexhokl/rds-backup
(iwr -useb https://raw.githubusercontent.com/alexhokl/dotfiles/windows10/.gitconfig).Content > .gitconfig
[Open .gitconfig in Visual Studio Code to change encoding and line-ending]
```
