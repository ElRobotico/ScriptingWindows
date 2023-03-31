function log {
    param ( [Parameter(Mandatory=$true)] [string] $testo, [Parameter(Mandatory=$true)][string] $colore )
    $data = Get-Date -Format "HH:mm:ss dd/MM/yyyy"
    switch ($colore) {
        "green"  { $output = "$data - Info | $testo";
                   Write-Host $output  -ForegroundColor $colore;
                   break 
                 }
        "yellow" { $output = "$data - Warning | $testo";
                   Write-Host $output -ForegroundColor $colore;
                   break 
                 }
        "red"    { $output = "$data - ERROR | $testo";
                   Write-Host $output -ForegroundColor $colore;
                   break
                 }
        Default {
                  Write-Host "LOGGER ERROR - Unknow color selected expected: Green, Yellow or Red. Got $colore"
                }
    }

    return $output;
}
log -testo "Inizio esecuzione" -colore "red" | Out-File -FilePath "C:\temp\log.txt" -Append