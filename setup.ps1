# Apps
scoop bucket add main
scoop install psutils git 7zip

scoop bucket add nerd-fonts;
scoop install FiraCode FiraCode-NF;

scoop bucket add extras;
scoop install alacritty starship qbittorrent telegram vscode imageglass vlc discord chromium;

scoop bucket add versions;
scoop install steam;

# Configs

## alacritty
New-Item -Path "$env:APPDATA/alacritty" -ItemType SymbolicLink -Value ".config/alacritty" -Force

## PoweSheel
$pwsheel = [environment]::getfolderpath("mydocuments") + "/WindowsPowerShell"
New-Item -Path $pwsheel -ItemType SymbolicLink -Value ".spec_config/WindowsPowerShell" -Force

## VSCode
New-Item -Path "$env:userprofile/scoop/apps/vscode/current/data/user-data/User/settings.json" -ItemType SymbolicLink -Value ".spec_config/vscode/settings.json" -Force