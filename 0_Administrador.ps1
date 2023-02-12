####################################################
# Shell: Powershell (como administrador)
# Pasos: # Ejecutar los scripts
####################################################

# Esta verificación se realiza para asegurarse de que el script de PowerShell se está ejecutando como administrador.
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

If ($isAdmin) {
    $currentUserName = $env:UserName
    Write-Host "Está ejecutando como administrador: $currentUserName"

    $trackFile = Join-Path $PWD "track.txt"
    $trackContent = Get-Content $trackFile

    If (!(Test-Path -Path $trackFile -PathType Leaf)) {
        Write-Host "Introduzca las credenciales de tu cuenta de usuario. No se trata necesariamente del administrador"
        $credential = Get-Credential
        Start-Process powershell.exe -Credential $credential -ArgumentList "-File `"$($PWD)\1_Configuracion_Basica.ps1`""
        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\1a_Pre-Reboot.ps1`"" -Verb RunAs
        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\1b_Pre-Chocolatey.ps1`"" -Verb RunAs
    }

    If ($trackContent -eq "step 1 completed") {
        Write-Host "Estamos en el segundo paso, hasta ahora reiniciaste una vez"

        # Preparando para el siguiente reboot
        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\1a_Pre-Reboot.ps1`"" -Verb RunAs

        # Actualizando el tracking
        $outputFilename = "track"
        $outputPath = Join-Path $PWD $outputFilename
        "step 2 completed" | Out-File -FilePath $outputPath -Encoding ascii -Force

        # Verificar que se creó el archivo correctamente
        Get-ChildItem $outputPath

        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\2_InstallingChocoPackages.ps1`"" -Verb RunAs

    } ElseIf ($trackContent -eq "step 2 completed") {
        Write-Host "Estamos en el tercer paso, hasta ahora reiniciaste dos veces"
        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\3_InstallingPythonPackages.ps1`"" -Verb RunAs
        Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\4_InstallingNPM.ps1`"" -Verb RunAs
        Write-Host "¡Hemos terminado! No hay un Exit automático para ver posibles errores registrados"
    }
    
} else {
    Write-Host "Lo sentimos, se requieren privilegios administrativos para ejecutar este script"
    Exit
}