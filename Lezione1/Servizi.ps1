<# Abilitare policy di esecuzione per alcuni script #>
Set-ExecutionPolicy Unrestricted

<# Recuperare l'help del comando Get-Service #>
Get-Help Get-Service

<# Aggiornare le guide dei comandi #>
Update-Help

<# Visualizzare Alias #>
Get-Alias -Definition Get-Service

<# Ottenere servizio "Print Spooler" e riavviarlo #>
Get-Service -Name "Spooler"
Restart-Service -Name "Spooler"