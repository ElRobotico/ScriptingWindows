$data = Get-Date -format "HH:mm dd/MM/yyyy"
$color = Read-Host 

function log {
    param ($messaggio, $colore)
    if ($colore -eq "Green") {
    $messaggio = "Info | $messaggio"
    Write-Host "$messaggio " -ForegroundColor $colore}
    if ($colore -eq "Yellow") {
    $messaggio = "Warning | $messaggio"
    Write-Host "$messaggio " -ForegroundColor $colore}
    if ($colore -eq "Red") {
    $messaggio = "ERROR | $messaggio"
    Write-Host "$messaggio " -ForegroundColor $colore}
    Return $messaggio
}

$output = log -messaggio "Inizio Esecuzione alle $data" -colore "$color" | Out-File -FilePath "C:\Temp\log.txt" -Append