####################################################
# Shell: Powershell (como administrador)
# Pasos: # Instalar Chocolatey
####################################################

# Define the number of times to retry
$maxRetries = 3
$retryCount = 0

# Check if Chocolatey is already installed
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Output "Chocolatey is already installed."
  } else {
    # Install Chocolatey
    Write-Output "Instalando Chocolatey..."
    $batFile = ".\1.2_Instalar_Chocolatey.bat"
    do {
        $retryCount++
        if (Test-Path $batFile) {
            Start-Process $batFile -Wait
            Write-Output "Chocolatey installation complete. Verifying installation..."
            $checkCommand = "Start-Process powershell -Verb RunAs -ArgumentList '-NoExit', 'choco'"
            $checkResult = Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", $checkCommand -PassThru
            if ($checkResult.ExitCode -eq 0) {
                Write-Output "Chocolatey installed successfully."
                break
            }
        }
        Write-Warning "La instalación de Chocolatey falló. Volvemos a intentar en 10 segundos..."
        Start-Sleep -Seconds 10
    } while ($retryCount -lt $maxRetries)

    if ($retryCount -eq $maxRetries) {
        Write-Warning "No se ha podido instalar Chocolatey correctamente luego de $maxRetries intentos."
        Exit 1
    }
}

# Ask if the user wants to restart the computer
$restart = Read-Host "¿Deseas reiniciar? (y/n) Es recomendable."
if ($restart -eq "y") {
    Restart-Computer -Force
}