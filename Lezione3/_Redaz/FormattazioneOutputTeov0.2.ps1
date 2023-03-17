# FormattazioneOutputTeo.ps1
#
# Version History
# v0.1 -STESURA INIZIALE - Genera una lista dei primi 20 processi in esecuzione, in ordine decrescente in base all'ID.
#                          In fine esporta la lista in un file CSV nella cartella C:\Temp
#
# Autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
# Data prima stesura: 10/03/2023
# Data ultima modifica: 17/03/2023
# Ultimo autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
#
# Qualsiasi riproduzione non autorizzata, anche parziale, e'vietata
#
# NOTE IMPORTANTI:
# -Non effettuate alcuna modifica se non sapete dove mettere le mani
# REQUISITI:
# Eseguire lo script solo da Amministratore
# Avere una cartella C:\Temp

$DatadiOggi = Get-Date -Format "ddMMyyyy"
# crea una variabile nel quale salvare la data di oggi nel formato giorno/mese/anno

$path = "C:\Temp" + "\$DatadiOggi" + "_Process.csv"
# crea una variabile nel quale l'utente può indicare la cartella a piacere nel quale salvare il file

$indice = "ID"
$Topprocess = 20

Get-Process | Select-Object -First $Topprocess | Sort-Object $indice -Descending | Export-Csv -Path "$path"
# tramite get-process si estraggono tutti processi in esecuzione, Select-object seleziona i primi 20 processi, sort-object li ordina in base all'ID in ordine decrescente, export-csv esporta il file nella cartella C:\Temp