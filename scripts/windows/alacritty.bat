@echo off

@rem Удалить символическую ссылку если она уже была
if not exist "!%APPDATA%\alacritty!" rmdir /s /q %APPDATA%\alacritty

@rem Создать символическую ссылку
mklink /D "%APPDATA%\alacritty" "%CD%\.config\alacritty"

@rem Добавить в контекстное меню
reg add HKEY_CLASSES_ROOT\Directory\Background\shell\Alacritty /v Icon /d "C:\Software\Alacritty\Alacritty.exe" /f
reg add HKEY_CLASSES_ROOT\Directory\Background\shell\Alacritty\command /ve /d "C:\Software\Alacritty\Alacritty.exe" /f

@rem Создать ссылку в меню пуск и добавить хоткей CTRL+ALT+T
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Alacritty.lnk'); $s.TargetPath='C:\Software\Alacritty\Alacritty.exe'; $s.Hotkey = 'CTRL+ALT+T'; $s.Save()"