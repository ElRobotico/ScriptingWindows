################################################
# Script-1.ps1
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

$path = "C:\Windows"
Get-ChildItem $path -File | ForEach-Object {
    Write-Host $_.Name $_.Name.Length
}