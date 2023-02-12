####################################################
# Shell: Powershell (como administrador)
# Pasos: # Instalar aplicaciones a través de Chocolatey
####################################################

# Some packages are required by others. Here some of them.
# Tesseract: Ghostscript
# Jupyter: pandoc

# Create an array with the packages to install. You should install anaconda and Python by yourself
$packages = @("7zip", "aria2", "ffmpeg-full", "Ghostscript", "git", "golang", "gpg4win", "hugo-extended", "imagemagick", "krita", "mpc-hc-clsid2", "nano", "obs-studio", "openssl", "pandoc", "pngquant", "rclone", "tesseract", "yt-dlp", "wget", "gallery-dl", "nvm", "vscode", "barrier")
# You should install "anaconda" and "Python" by yourself. There are some issues.
# Recommended to use " Python 3.7.1"

foreach ($package in $packages) {
  # Add a counter to show the progress
  $i = $i + 1
  # Get the total number of packages to uninstall
  $count = $packages.Count

  # Check if the package is already installed
  $pkg = Get-Package $package -AllVersions
  if ($pkg -eq $null) {
    Write-Host "Instalando ($i/$count): $package"
    choco install $package -y
  } else {
    Write-Host "$package ya esta instalado"
  }
}

# Ask if the user wants to restart the computer
$restart = Read-Host "¿Deseas reiniciar? (y/n) Es recomendable."
if ($restart -eq "y") {
    Restart-Computer -Force
}