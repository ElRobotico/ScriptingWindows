$servizio=Get-Service 'Razer Synapse Service'
while($servizio.Status -eq "Running"){
    Write-Host "Il servizio $($servizio.Name) è in esecuzione" -ForegroundColor DarkMagenta
    Start-Sleep -Seconds 5
    $servizio=Get-Service 'Razer Synapse Service'
    }
Write-Host "Il servizio $($servizio.Name) non è in esecuzione" -ForegroundColor Red