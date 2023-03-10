# Esercizio1.ps1
# Versione 1.0
# Script per manipolare la data

# Ottieni la data di oggi
$DataDiOggi = Get-Date
# Aggiungi sette giorni
$PiuSetteGiorni = $DataDiOggi.AddDays(7)
# Aggiungi due ore
$PiuDueOre = $PiuSetteGiorni.AddHours(2)
# Definisci il formato con "GetDateTimeFormats"
$finish = $PiuDueOre.GetDateTimeFormats('s')
# Stampa la data formattata
Write-Host "$finish"