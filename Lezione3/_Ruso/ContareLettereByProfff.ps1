<# Creare uno script che richiede in input all'utente alcuni versi del canto 33 del paradiso della divina commedia.

La stringa deve essere manipolata rimuovendo gli spazi e contando le volte in cui compare il carattere "a"

Se il numero dei caratteri è piu di 6, stampare a schermo il testo "CLARO";

Se il numero dei caratteri è meno di 6, stampare a schermo il testo "CLARO" in verde;

Se il numero dei caratteri è =6, stampare a schermo il testo "CLARO" in giallo. #>


$Testo = "casa casa casa"
$TestoNoSpazi = $Testo.Replace(" ","")

<# 1st Method  ($TestoNoSpazi | Select-String -Pattern "a" -AllMatches).Matches.Count  #>

<# 2nd Method #> $ContoA = ($TestoNoSpazi.ToCharArray() | Where-Object { $_ -eq "a" }).Count 

if ($ContoA -gt 6) { Write-Host "CLARO" }
if ($ContoA -lt 6) { Write-Host "CLARO" -ForegroundColor Green }
if ($ContoA -eq 6) { Write-Host "CLARO" -ForegroundColor Yellow }