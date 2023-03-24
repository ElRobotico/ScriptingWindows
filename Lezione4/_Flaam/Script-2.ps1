################################################
# Script-2.ps1
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

foreach ($service in Get-Service) {
    if ($service.Status -eq "Running"){ Write-Host $service.name $service.status -ForegroundColor Green}
    if ($service.Status -eq "Stopped"){ Write-Host $service.name $service.status -ForegroundColor Red}
}