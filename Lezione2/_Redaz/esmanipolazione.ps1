# esmanipolazioneTeo.ps1#
# Version History
# v0.1 -STESURA INIZIALE -Permette all'operatore di estrarre il nome di un file a partire da un percorso
#
# Autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
# Data prima stesura: 10/03/2023
# Data ultima modifica: 10/03/2023
# Ultimo autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
#
# Qualsiasi riproduzione non autorizzata, anche parziale, e'vietata
#
# NOTE IMPORTANTI:
# -Non effettuate alcuna modifica se non sapete dove mettere le mani

$path = "C:\Windows\System32\drivers\etc\lmhosts.sam\pippo"
$var = $path.Split("\").Count
$var2 = $var - 1
$final = $path.Split("\")[$var2]
Write-Host $final