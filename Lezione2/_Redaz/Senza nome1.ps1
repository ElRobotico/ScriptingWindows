#Es. riavviare il servizio spooler

$Servizio = Spooler
Restart-Service $Servizio

Get-Service -Name $Servizio | Restart-Service