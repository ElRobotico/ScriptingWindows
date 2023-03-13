################################################
# EsercitazioneMarco.ps1
# TLDR: Enumerare contenuto della cartella C:\Windows e convertire i dati in una pagina HTML
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 10/03/2023
# Data ultima modifica: 10/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

$path = Read-Host "Inserisci path"
$export = Read-Host "Inserisci path del file HTML da esportare"
Get-ChildItem "$path" | Select-Object "Name" | ConvertTo-Html | Out-File "$export"