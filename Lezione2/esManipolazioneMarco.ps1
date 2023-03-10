# Creare uno script che, dato in ingresso un percorso completo di un file, ritorni in uscita solo il nome del file.
# Autore: DrippyFlaam
$Directory = "C:\Windows\System32\drivers\etc\lmhosts.sam" # Directory
$Directory.Split('\')[5] # Split dell'array con '\' e scelta della 5a row