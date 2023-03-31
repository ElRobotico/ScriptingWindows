################################################
# Script1.ps1
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 31/03/2023
# Data ultima modifica: 31/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

# Variabile data
$data = Get-Date -Format "HH:mm dd/MM/yyyy"

# Funzione di log
function log {
    param (
        $testo,
        $colore
    )
    if ($colore -eq "Green") {
        Write-Host "Info | $testo" -ForegroundColor "Green"
    }
    if ($colore -eq "Yellow") {
        Write-Host "Warning | $testo" -ForegroundColor "Yellow"
    }
    if ($colore -eq "Red") {
        Write-Host "ERROR | $testo" -ForegroundColor "Red"
    }
}

# Funzione chiamata
log -testo "Inizio Esecuzione alle $data" -colore "Red"
