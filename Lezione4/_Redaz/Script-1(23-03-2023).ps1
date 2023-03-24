# Script-1.ps1
#
# Version History
# v0.1 -STESURA INIZIALE - stampa a video il nome del file e il numero di caratteri da cui è composto
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
# Avere una cartella C:\Windows
$path = "C:\Windows"
Get-ChildItem $path -File | ForEach-Object {
    Write-Host $_.Name $_.Name.Length
}