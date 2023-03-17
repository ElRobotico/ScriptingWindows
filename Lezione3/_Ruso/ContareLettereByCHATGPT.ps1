<# Creare uno script che richiede in input all'utente alcuni versi del canto 33 del paradiso della divina commedia.

La stringa deve essere manipolata rimuovendo gli spazi e contando le volte in cui compare il carattere "a"

Se il numero dei caratteri è piu di 6, stampare a schermo il testo "CLARO";

Se il numero dei caratteri è meno di 6, stampare a schermo il testo "CLARO" in verde;

Se il numero dei caratteri è =6, stampare a schermo il testo "CLARO" in giallo. #>

# Richiedi all'utente di inserire alcuni versi del Canto 33 del Paradiso
$versi = Read-Host "Inserisci alcuni versi del Canto 33 del Paradiso"

# Rimuovi gli spazi dalla stringa e controlla il numero di occorrenze della lettera "a"
$numero_a = ($versi -replace "\s","" | Select-String -Pattern "a" -AllMatches).Matches.Count

# Verifica il numero di caratteri e stampa il messaggio appropriato
if ($numero_a -gt 6) {
  Write-Host "CLARO"
} elseif ($numero_a -lt 6) {
  Write-Host -ForegroundColor Green "CLARO"
} else {
  Write-Host -ForegroundColor Yellow "CLARO"
}