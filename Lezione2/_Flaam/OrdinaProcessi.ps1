################################################
# OrdinaProcessiMarco.ps1
# TLDR: Genera lista dei processi in esecuzione sul computer, ne seleziona solo i primi 20 e li ordina decrescentemente in base all'ID del processo
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 10/03/2023
# Data ultima modifica: 10/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################
$DataDiOggi = Get-Date -Format "dd-MM-yyyy"
$exportpath = "C:\temp"
Get-Process | Select-Object -First 20 | Sort-Object -Property ID | Export-CSV -Path "$exportpath\$datadioggi`_Process.csv"