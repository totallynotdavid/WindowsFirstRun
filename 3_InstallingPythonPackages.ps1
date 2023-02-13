####################################################
# Shell: Powershell (como administrador)
# Pasos: # Instalar paquetes de Python
#        # Configurar ocrmypdf
####################################################

# Crear un array con los paquetes a instalar

$packages = @("poetry", "ocrmypdf", "numpy", "pandas", "matplotlib", "scipy")

foreach ($package in $packages) {
  $i = $i + 1
  $count = $packages.Count
  Write-Host "Instalando ($i/$count): $package"
  pip install $package
}

# Descargar datos en español para Tesseract
$trainedDataUri = "https://github.com/tesseract-ocr/tessdata/raw/main/spa.traineddata"
$trainedDataPath = "spa.traineddata"

try {
    Invoke-WebRequest -Uri $trainedDataUri -OutFile $trainedDataPath -ErrorAction Stop
} catch {
    Write-Host "Hubo un error descargando el archivo: $_.Exception.Message"
    Exit
}

# Move the trained data file to the Tesseract folder
$tessdataPath = "C:\Program Files\Tesseract-OCR\tessdata"
$trainedDataDestPath = Join-Path $tessdataPath "spa.traineddata"

try {
    Move-Item $trainedDataPath $trainedDataDestPath -Force -ErrorAction Stop
} catch {
    Write-Host "Hubo un error al mover el archivo: $_.Exception.Message"
    Exit
}

Write-Host "Los datos en español de Tesseract se han descargado e instalado correctamente"