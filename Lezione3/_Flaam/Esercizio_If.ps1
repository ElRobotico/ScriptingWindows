################################################
# esManipolazioneMarco.ps1
# TLDR: Creare uno script che richiede, in input all'utente, alcuni versi del canto 33 del Paradiso della Divina Commedia.
#       La stringa deve essere manipolata rimuovendo gli spazi e contando le volte in cui compare il carattere "a"
#       Se il numero dei caratteri è più di 6, stampare a schermo il testo "REDACTED"
#       Se il numero dei caratteri è meno di 6, stampare a schermo il testo "REDACTED" in verde
#       Se il numero dei caratteri è uguale a 6, stampare a schermo il testo "REDACTED" in giallo
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 17/03/2023
# Data ultima modifica: 17/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

$verso = Read-Host "Inserisci un verso del canto 33"
$conta_a = ($verso -Replace "\s","" | Select-String -Pattern "a" -AllMatches).Matches.Count
if ($conta_a -gt 6) {
    Write-Host "REDACTED"
} elseif ($conta_a -lt 6) {
    Write-Host "REDACTED" -ForegroundColor Green
} else {
    Write-Host "REDACTED" -ForegroundColor Yellow
}