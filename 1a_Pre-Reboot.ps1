$scriptFilename = "0_Administrador.ps1"
$scriptPath = Join-Path $PWD $scriptFilename

# Definiendo el nombre y la descripción la tarea programada
$taskName = "RunScriptAfterReboot"
$taskDescription = "Runs a PowerShell script as an administrator after system reboot"

# Pedir al usuario las credenciales para ejecutar la tarea
$credential = Get-Credential -Message "Enter the credentials to run the scheduled task as"
$trigger = New-ScheduledTaskTrigger -AtStartup

# Creación de la tarea programada
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`"" -RunLevel Highest
Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Trigger $trigger -Action $action -User $username -Password $password

# Verificar que se creó la tarea correctamente
Get-ScheduledTask -TaskName $taskName

#####################################
# Se crea un archivo llamado "track" al culminar de programar el script "0_Administrator.ps1", para evitar que se ejecuten comandos pasados

$outputFilename = "track"
$outputPath = Join-Path $PWD $outputFilename
"step 1 completed" | Out-File -FilePath $outputPath -Encoding ascii -Force

# Verificar que se creó el archivo correctamente
Get-ChildItem $outputPath