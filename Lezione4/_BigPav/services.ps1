# services.ps1
#
## Version History
# v0.1 - STESURA INIZIALE
# v0.2 - changed from tabulation separator to -- separator in write host statement
#
## Autore: B1gp
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: B1gp
#

$services = Get-Service 

foreach ($service in $services){
    if($service.status -eq "running"){
        Write-Host -ForegroundColor Green "$($service.Name) -- $($service.status)" | Format-Table Name, status
    } elseif($service.status -eq "stopped"){
        Write-Host -ForegroundColor Red "$($service.name) -- $($service.status)" | Format-Table Name, status
    }
}