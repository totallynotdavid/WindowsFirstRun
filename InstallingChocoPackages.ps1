# Install Chocolatey packages

# Create an array with the packages to install
# Some packages are required by others. Here some of them.
# Tesseract: Ghostscript
# Jupyter: pandoc
$packages = @("7zip", "aria2", "ffmpeg-full", "Ghostscript", "git", "golang", "gpg4win", "hugo-extended", "imagemagick", "krita", "mpc-hc-clsid2", "nano", "obs-studio", "openssl", "pandoc", "pngquant", "python3", "rclone", "--pre tesseract", "yt-dlp", "anaconda3", "wget", "gallery-dl", "nvm", "vscode", "authy-desktop", "barrier")

foreach ($package in $packages) {
  # Add a counter to show the progress
  $i = $i + 1
  # Get the total number of packages to uninstall
  $count = $packages.Count

  Write-Host "Instalando ($i/$count): $package"
  choco install $package -y
}

# Create a Windows Task Scheduler job
$packagePath = "./InstallingPythonPackages.ps1"
$packagePath = Resolve-Path $packagePath
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-File "$packagePath"'
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName 'PythonPackages' -Settings $settings

# Run the task
Start-ScheduledTask -TaskName 'PythonPackages'

Restart-Computer -Force