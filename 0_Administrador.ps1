####################################################
# Shell: Powershell (como administrador)
# Pasos: # Ejecutar los scripts
####################################################

# Esta verificación se realiza para asegurarse de que el script de PowerShell se está ejecutando como administrador.
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    $currentUserName = $env:UserName
    Write-Host "Está ejecutando como administrador: $currentUserName"
    Write-Host "Introduzca las credenciales de tu cuenta de usuario. No se trata necesariamente del administrador"
    $credential = Get-Credential
    Start-Process powershell.exe -Credential $credential -ArgumentList "-File `"$($PWD)\1_Configuracion_Basica.ps1`""
    Start-Process powershell.exe -ArgumentList "-File `"$($PWD)\1.1_Pre-Chocolatey.ps1`"" -Verb RunAs
} else {
    Write-Host "Lo sentimos, se requieren privilegios administrativos para ejecutar este script"
    Exit
}