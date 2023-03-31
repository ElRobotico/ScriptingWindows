################################################
# Esercizio2.ps1
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 31/03/2023
# Data ultima modifica: 31/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

# Estrae i servizi attivi sulla postazione
$services = Get-Service | Where-Object {$_.Status -eq "Running"}

# Ordina i servizi per nome del processo
$services = $services | Sort-Object -Property Name

# Salva i servizi attivi in un file CSV 
$csvPath = "C:\temp\servizi_attivi.csv"
if (Test-Path $csvPath) {
    # Se il file esiste, crea una sottocartella "archivio" se non esiste già
    $archivePath = "C:\temp\archivio"
    if (-not (Test-Path $archivePath)) {
        New-Item -ItemType Directory -Path $archivePath | Out-Null
    }
    
    # Sposta il file esistente nella sottocartella "archivio"
    $dateTime = Get-Date -Format "yyyyMMdd_HHmmss"
    $archiveFilePath = "$archivePath\servizi_attivi_$dateTime.csv"
    Move-Item -Path $csvPath -Destination $archiveFilePath
    
    # Aggiorna il log con le informazioni sullo spostamento del file
    $logPath = "C:\temp\scheduledtaskrun.log"
    $logMessage = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - Il file $csvPath è stato spostato in $archiveFilePath`n"
    Add-Content -Path $logPath -Value $logMessage
}

# Salva i servizi attivi nel file CSV
$services | Export-Csv -Path $csvPath -NoTypeInformation -Force

# Aggiorna il log con le informazioni sui servizi attivi e inattivi
$stoppedServices = Get-Service | Where-Object {$_.Status -eq "Stopped"}
$logMessage = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - Servizi attivi: $($services.Count), Servizi inattivi: $($stoppedServices.Count)`n"
Add-Content -Path $logPath -Value $logMessage