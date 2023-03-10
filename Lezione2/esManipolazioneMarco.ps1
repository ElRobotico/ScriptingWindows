################################################
# esManipolazioneMarco.ps1
# TLDR: Creare uno script che, dato in ingresso un percorso completo di un file, ritorni in uscita solo il nome del file.
################################################
# Version History
# v0.1 | Prima versione
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 10/03/2023
# Data ultima modifica: 10/03/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

$Directory = "C:\Windows\System32\drivers\etc\lmhosts.sam" # Directory
$Directory.Split('\')[5] # Split dell'array con '\' e scelta della 5a row