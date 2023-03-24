# services.ps1
#
## Version History
# v0.1 -STESURA INIZIALE
#
## Autore: B1gp
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: B1gp
#

$services = Get-Service 

foreach ($service in $services){
    if($service.status -eq "running"){
        Write-Host -ForegroundColor Green "$($service.Name) `t $($service.status)" | Format-Table Name, status
    } elseif($service.status -eq "stopped"){
        Write-Host -ForegroundColor Red "$($service.name) `t $($service.status)" | Format-Table Name, status
    }
}