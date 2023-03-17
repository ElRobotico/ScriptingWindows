# esFormattazioneBigpav.ps1
#
## Version History
# v0.1 -STESURA INIZIALE
#
## Autore: B1gp
# Data prima stesura: 10/03/2023
# Data ultima modifica: 12/03/2023
# Ultimo autore: B1gp
#

$dataDiOggi = Get-Date -Format "ddMMyyyy"
$exportPath = "C:\temp"
Get-Process | Select-Object -First 20 | Sort-Object -Property ID -Descending | Export-Csv -Path "$exportPath\$dataDiOggi`_Process.csv"
