####################################################
# Shell: Powershell (como administrador)
# Pasos: # Instalar paquetes de Python
#        # Configurar ocrmypdf
####################################################

# Create an array with the packages to install

$packages = @("poetry", "ocrmypdf", "numpy", "pandas", "matplotlib", "scipy")

foreach ($package in $packages) {
  $i = $i + 1
  $count = $packages.Count
  Write-Host "Instalando ($i/$count): $package"
  pip install $package
}

# Download Spanish language data for Tesseract
Invoke-WebRequest -Uri "https://github.com/tesseract-ocr/tessdata/raw/main/spa.traineddata" -OutFile spa.traineddata

# Check if the file exists
if (Test-Path spa.traineddata) {
  # Move the file to the Tesseract folder
  Move-Item spa.traineddata "C:\Program Files\Tesseract-OCR\tessdata\spa.traineddata"
}

# Start-Process powershell.exe -Verb Runas -ArgumentList '-NoExit -File ./InstallingNPM.ps1'