function log {
    param ( $testo, $colore )
    $data = Get-Date -Format "HH:mm:ss dd/MM/yyyy"
    switch ($colore) {
        "green"  { $output = "$data - Info | $testo";
                  Write-Host $output  -ForegroundColor $colore;
                  Out-File -FilePath "C:\temp\log.txt" -InputObject $output -Append ;
                  break 
                 }
        "Yellow" { $output = "$data - Warning | $testo";
                   Write-Host $output -ForegroundColor $colore;
                   Out-File -FilePath "C:\temp\log.txt" -InputObject $output -Append;
                   break 
                 }
        "Red"    { $output = "$data - ERROR | $testo";
                   Write-Host $output -ForegroundColor $colore;
                   Out-File -FilePath "C:\temp\log.txt"-InputObject $output -Append;
                   break
                 }
    }
    
}
log -testo "Inizio esecuzione" -colore "red"