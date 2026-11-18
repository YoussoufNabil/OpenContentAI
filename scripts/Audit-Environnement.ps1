# OpenContentAI - Audit initial de l'environnement Windows
# Lecture seule : le script collecte des informations techniques et écrit un rapport texte.
# Il n'installe rien, ne modifie pas WSL/Docker et ne collecte volontairement aucun secret.

$ErrorActionPreference = 'SilentlyContinue'
$Rapport = Join-Path $env:USERPROFILE 'Desktop\OpenContentAI_AUDIT.txt'

function Add-Section {
    param([string]$Titre)
    Write-Host "`n$('=' * 72)"
    Write-Host $Titre
    Write-Host ('=' * 72)
}

"OpenContentAI - Rapport d'audit" | Set-Content -Path $Rapport -Encoding UTF8
("Date : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')) | Add-Content -Path $Rapport

Add-Section '1. SYSTEME WINDOWS'
$OS = Get-CimInstance Win32_OperatingSystem
$Ordinateur = Get-CimInstance Win32_ComputerSystem
[PSCustomObject]@{
    Systeme = $OS.Caption
    Version = $OS.Version
    Build = $OS.BuildNumber
    Architecture = $OS.OSArchitecture
    RAM_Go = [math]::Round($Ordinateur.TotalPhysicalMemory / 1GB, 2)
} | Format-List | Tee-Object -FilePath $Rapport -Append

Add-Section '2. PROCESSEUR'
Get-CimInstance Win32_Processor |
    Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed |
    Format-List | Tee-Object -FilePath $Rapport -Append

Add-Section '3. BARRETTES MEMOIRE'
Get-CimInstance Win32_PhysicalMemory |
    Select-Object Manufacturer, Capacity, Speed, ConfiguredClockSpeed, DeviceLocator |
    Format-Table -AutoSize | Tee-Object -FilePath $Rapport -Append

Add-Section '4. CARTES GRAPHIQUES'
Get-CimInstance Win32_VideoController |
    Select-Object Name, DriverVersion, VideoModeDescription |
    Format-List | Tee-Object -FilePath $Rapport -Append

Add-Section '5. NVIDIA (SI DISPONIBLE)'
if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
    nvidia-smi --query-gpu=name,driver_version,memory.total,memory.used,memory.free,utilization.gpu --format=csv,noheader |
        Tee-Object -FilePath $Rapport -Append
} else {
    'Aucun outil nvidia-smi détecté ; le test CUDA est ignoré.' | Tee-Object -FilePath $Rapport -Append
}

Add-Section '6. STOCKAGE'
Get-Volume |
    Where-Object DriveLetter |
    Select-Object DriveLetter, FileSystemLabel,
        @{N='Taille_Go';E={[math]::Round($_.Size / 1GB, 2)}},
        @{N='Libre_Go';E={[math]::Round($_.SizeRemaining / 1GB, 2)}} |
    Sort-Object DriveLetter |
    Format-Table -AutoSize | Tee-Object -FilePath $Rapport -Append

Add-Section '7. WSL2'
'--- wsl --version ---' | Tee-Object -FilePath $Rapport -Append
wsl --version 2>&1 | Tee-Object -FilePath $Rapport -Append
'--- wsl --status ---' | Tee-Object -FilePath $Rapport -Append
wsl --status 2>&1 | Tee-Object -FilePath $Rapport -Append
'--- wsl --list --verbose ---' | Tee-Object -FilePath $Rapport -Append
wsl --list --verbose 2>&1 | Tee-Object -FilePath $Rapport -Append

Add-Section '8. DOCKER'
'--- docker version ---' | Tee-Object -FilePath $Rapport -Append
docker version 2>&1 | Tee-Object -FilePath $Rapport -Append
'--- docker info résumé ---' | Tee-Object -FilePath $Rapport -Append
docker info --format 'Serveur={{.ServerVersion}} ; OS={{.OperatingSystem}} ; Type={{.OSType}} ; Architecture={{.Architecture}} ; CPU={{.NCPU}} ; Memoire={{.MemTotal}}' 2>&1 |
    Tee-Object -FilePath $Rapport -Append

Add-Section '9. TEST DOCKER HELLO-WORLD'
docker run --rm hello-world 2>&1 | Tee-Object -FilePath $Rapport -Append

Add-Section '10. VIRTUALISATION'
Get-CimInstance Win32_ComputerSystem |
    Select-Object HypervisorPresent |
    Format-List | Tee-Object -FilePath $Rapport -Append

Add-Section 'FIN'
"Audit terminé. Rapport : $Rapport" | Tee-Object -FilePath $Rapport -Append
Write-Host "`nRapport créé : $Rapport"
Write-Host 'Relire le rapport et masquer les informations personnelles avant tout partage public.'
