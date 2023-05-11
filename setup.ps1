# Apps
scoop bucket add extras;
scoop install 7zip git alacritty qbittorrent telegram vscode vlc discord googlechrome chromium;

# Configs
Copy-Item -Path ".config/alacritty/" -Destination $env:APPDATA -recurse -Force;