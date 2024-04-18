set filePath=%1
set image=%2
shift
powershell -WindowStyle Hidden -File "%filePath%\change-wallpaper.ps1" %image%