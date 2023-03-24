# nChars.ps1
#
## Version History
# v0.1 -STESURA INIZIALE
#
## Autore: B1gp
# Data prima stesura: 24/03/2023
# Data ultima modifica: 24/03/2023
# Ultimo autore: B1gp
#

$dir = "C:\Windows\Temp"

$files = Get-ChildItem $dir -File

foreach ($file in $files){
    Write-Host $file.Name + "length:" + $file.Name.Length
}