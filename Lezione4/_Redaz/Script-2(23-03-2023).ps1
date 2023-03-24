# Script-2.ps1
#
# Version History
# v0.1 -STESURA INIZIALE - Mostra i tutti i servizi presenti sul  computer in verde se si trovano in esecuzione, in rosso se fermi
#
# Autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
#
# Qualsiasi riproduzione non autorizzata, anche se parziale, e'vietata
#
# NOTE IMPORTANTI:
# -Non effettuate alcuna modifica se non sapete dove mettere le mani
# REQUISITI:
# Eseguire lo script solo da Amministratore

foreach ($service in Get-Service) {
    if ($service.Status -eq "Running"){ Write-Host $service.name $service.status -ForegroundColor Green}
    if ($service.Status -eq "Stopped"){ Write-Host $service.name $service.status -ForegroundColor Red}
}