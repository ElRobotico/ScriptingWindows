# Script-1.ps1
#
# Version History
# v0.1 -STESURA INIZIALE - Estrae i log dell'antivirus
#
# Autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
# Data prima stesura: 13/05/2023
# Data ultima modifica: 13/05/2023
# Ultimo autore: Matteo Redaelli - matteo.redaelli@itstechtalentfactory.it
#
# Qualsiasi riproduzione non autorizzata, anche se parziale, e'vietata
#
# NOTE IMPORTANTI:
# -Non effettuate alcuna modifica se non sapete dove mettere le mani
# REQUISITI:
# Nessuno


#variabili
$lognumber = Read-Host "Inserire il numero di log totali che si vuole visualizzare ed esportare (Verranno estratti a partire dal più recente)"
$path = Read-Host "Percorso nel quale salvare il file contenente tutti i log (Esempio C:\Windows)"
$date = Get-Date -Format dd-MM-yyyy_HH-mm-ss
$filename = "\log_" + $date + ".txt"
$finalpath = $path + $filename

#estrazione dei log
try {
    Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" -MaxEvents $lognumber | Format-List | Out-File $finalpath
    Write-Host "Il file è stato salvato in" $finalpath -ForegroundColor Green
}
catch {
    Write-Host "Errore: " $_.Exception.Message -ForegroundColor Red
}