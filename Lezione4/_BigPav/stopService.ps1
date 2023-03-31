$time = Get-Date
$outfile = "C:\temp\script.txt"
$time | Out-File -FilePath $outfile

while ($true){
    if ($(Get-Service -Name 'OneDrive Updater Service').Status -eq 'running'){
        "SERVIZIO IN ESECUZIONE" | Out-File -FilePath $outfile -Append
    }else{
        $timeExited = Get-Date
        echo "ESECUZIONE TERMINATA -  $($timeExited) Durata esecuzione: $($timeExited - $time)" | Out-File -FilePath $outfile -Append
        Exit
    }
    Start-Sleep -Seconds 5
}
