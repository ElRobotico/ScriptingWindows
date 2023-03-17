# esIF.ps1
#
## Version History
# v0.1 -STESURA INIZIALE
#
## Autore: B1gp
# Data prima stesura: 17/03/2023
# Data ultima modifica: 17/03/2023
# Ultimo autore: B1gp
#

$toBeFound = "a"
$treshold = 6
$verso = Read-Host "Inserisci un verso"

$occorrenze = ($verso -replace '\s','' | select-string -pattern $toBeFound -AllMatches).Matches.Count

if ($occorrenze -lt $treshold){
    Write-Host "REDACTED" -ForegroundColor Green
} elseif($occorrenze -eq $treshold){
    Write-Host "REDACTED" -ForegroundColor Yellow
} else{
    Write-Host "REDACTED"
}