# split.ps1
#
## Version History
# v0.1 -STESURA INIZIALE
#
## Autore: Lorenzo Pavesi
# Data prima stesura: 10/03/2023
# Data ultima modifica: 10/03/2023
# Ultimo autore: Lorenzo Pavesi
#

$path = Read-Host "Inserisci il path"
$exitPath = Read-Host "Inserisci il percorso dove vuoi avere il file html"

Get-ChildItem $path |Select-Object Name | ConvertTo-Html | Out-File "$exitpath\bigpav.html"