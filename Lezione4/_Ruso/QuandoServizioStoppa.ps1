# Salva la data e l'ora di inizio esecuzione
$startTime = Get-Date
$startTimeString = "Inizio esecuzione: " + $startTime.ToString()

# Scrivi la data e l'ora di inizio esecuzione nel file di log
Add-Content -Path "C:\log.txt" -Value $startTimeString

# Esegui un ciclo while per controllare il servizio Parsec
while ($true) {
    # Verifica lo stato del servizio Parsec
    $serviceStatus = Get-Service -Name "Parsec"
    
    # Se il servizio è in esecuzione, scrivi nel file di log e attendi 5 secondi
    if ($serviceStatus.Status -eq "Running") {
        $serviceRunningString = "Servizio in esecuzione"
        Add-Content -Path "C:\log.txt" -Value $serviceRunningString
        Start-Sleep -Seconds 5
    }
    # Se il servizio è stato stoppato, scrivi la data e l'ora di fine esecuzione nel file di log e calcola il tempo di esecuzione
    else {
        $endTime = Get-Date
        $endTimeString = "Fine esecuzione: " + $endTime.ToString()
        Add-Content -Path "C:\log.txt" -Value $endTimeString
        
        $executionTime = New-TimeSpan -Start $startTime -End $endTime
        $executionTimeString = "Tempo di esecuzione: " + $executionTime.ToString()
        Add-Content -Path "C:\log.txt" -Value $executionTimeString
        
        # Esci dal ciclo while
        break
    }
}