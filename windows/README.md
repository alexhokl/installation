### References

- [Boxstarter
  functions](https://github.com/chocolatey/boxstarter/tree/master/Boxstarter.WinConfig)

### Steps

- Open Powershell (v6 but not v7) with administrator privileges and run the following scripts

```ps1
Set-ExecutionPolicy AllSigned
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force
$computername = "alex-windows"
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/alexhokl/installation/master/windows/boxstarter.ps1 -DisableReboots
```

- Reboot to prepare .NET Framework installation

- Open Powershell with administrator privileges and run the following scripts

```ps1
choco install -y netfx-4.7-devpack
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/npm-list.txt", "$HOME\Desktop\npm-list.txt")
Get-Content $HOME\Desktop\npm-list.txt | ForEach-Object { npm i -g $_ }
$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$newPath=$oldPath+";$HOME\Desktop\git\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name GOPATH –Value "$HOME\Desktop\git"
```

- Open Powershell as a normal user and run the following scripts

```ps1
mkdir $HOME\Desktop\git
(iwr -useb https://raw.githubusercontent.com/alexhokl/dotfiles/windows10/.gitconfig).Content.Replace("`n", "`r`n") | Set-Content -Encoding utf8 $HOME\.gitconfig
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/vscode-extensions.txt", "$HOME\Desktop\vscode-extensions.txt")
Get-Content $HOME\Desktop\vscode-extensions.txt | ForEach-Object { code --install-extension $_ }
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/dotnet_tools", "$HOME\Desktop\dotnet_tools.txt")
Get-Content $HOME\Desktop\dotnet_tools.txt | ForEach-Object { dotnet tool install -g $_ }
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/requirements.txt", "$HOME\Desktop\requirements.txt")
python -m pip install --user -r $HOME\Desktop\requirements.txt
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/alexhokl/installation/master/go_packages", "$HOME\Desktop\go_packages.txt")
Get-Content $HOME\Desktop\go_packages.txt | ForEach-Object { go get -u $_ }
```

### WSL

Open Powershell with administrator privileges and run the following scripts

```sh
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Open Powershell as a normal user and run the following scripts

```sh
curl.exe -sSL -o ubuntu.appx https://aka.ms/wslubuntu2004
Add-AppxPackage .\ubuntu.appx
```
