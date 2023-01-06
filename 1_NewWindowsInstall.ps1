# UNINSTALL UNWANTED APPS

$packages = @("Clipchamp.Clipchamp", "Microsoft.YourPhone", "Microsoft.BingNews", "Microsoft.BingWeather", "Microsoft.XboxApp", "Microsoft.Todos", "Microsoft.WindowsMaps", "Microsoft.MicrosoftStickyNotes", "Microsoft.WindowsSoundRecorder", "Microsoft.GetHelp", "Microsoft.ZuneVideo", "Microsoft.People", "Microsoft.OneDriveSync", "Microsoft.3DBuilder", "Microsoft.Getstarted", "Microsoft.Microsoft3DViewer", "Microsoft.MicrosoftOfficeHub", "Microsoft.MicrosoftSolitaireCollection", "Microsoft.MicrosoftStickyNotes", "Microsoft.MixedReality.Portal", "Microsoft.Office.OneNote", "Microsoft.Print3D", "Microsoft.SkypeApp", "Microsoft.WindowsCamera", "Microsoft.WindowsFeedbackHub")

foreach ($package in $packages) {
  # Add a counter to show the progress
  $i = $i + 1
  # Get the total number of packages to uninstall
  $count = $packages.Count
  
  try {
    # Check if the app package is installed
    $app = Get-AppxPackage $package
    if ($app -ne $null) {
        Write-Output "Desintalando ($i/$count): $package"
        $job = Start-Job -ScriptBlock { Get-AppxPackage $package | Remove-AppxPackage }
        Wait-Job $job | Out-Null # Avoids the job from being written to the console
    } else {
        Write-Output "$package no esta instalado"
    }
  } catch {
      Write-Output "Error desintalando $package : $($_.Exception.Message)"
  }
}

# INSTALL APPS
# Also: https://gist.github.com/YoraiLevi/e1888ee1c06b34cb02d4b58b739301af
Get-AppxPackage Microsoft.PowerShell.Terminal | Add-AppxPackage

# SET WALLPAPER

# Set the path to the image file
# To use a different image, change the $imageWallpaperName variable
$imageWallpaperName = "Windows_Main.jpg"
$imageOriginFolderPath = ".\wallpaper"
$imageDestinationFolderPath = "C:\Users\Public\Pictures\Wallpaper"
$imageOriginPath = $imageOriginFolderPath + "\" + $imageWallpaperName
$imageDestinationPath = $imageDestinationFolderPath + "\" + $imageWallpaperName

# Check if the destination folder exists
if (Test-Path $imageDestinationFolderPath) {
  Copy-Item "$imageOriginPath" "$imageDestinationPath" -Force
  Write-Output "La carpeta de destino existe. Se ha copiado el archivo."
} else {
  New-Item -ItemType Directory -Path "$imageDestinationFolderPath" | Out-Null
  Copy-Item "$imageOriginPath" "$imageDestinationPath" -Force
  Write-Output "La carpeta de destino no existe. Se ha creado y copiado el archivo."
}

Write-Host "Actualizando el fondo de pantalla: $imageDestinationPath"

# Set the wallpaper style
$wallpaperStyle = 4 # 0 (Center) - 1 (Tile) - 2 (Stretch) - 3 (Fit) - 4 (Fill) - 5 (Span)

# Set the registry key
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper" -Value $imageDestinationPath
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallpaperStyle" -Value $wallpaperStyle
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 # 0 (Dark) - 1 (Light)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 # 0 (Dark) - 1 (Light)

# Refresh the desktop
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters

# Install Chocolatey
# Check if Chocolatey is installed
if (Get-Command choco -ErrorAction SilentlyContinue) {
  Write-Output "Chocolatey ya está instalado."
} else {
  # Install Chocolatey
  Write-Output "Instalando Chocolatey..."
  Start-Process ./InstallingChoco.bat -Wait
  Write-Output "Chocolatey instalado."
}

#Restart-Computer -Force