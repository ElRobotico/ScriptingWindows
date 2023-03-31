#services.ps1
#autore: B1gp
#versione: v1.0
#data creazione: 31/03/2023
#data ultima modifica: 31/03/2023

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

$servizi = Get-Service
$logpath = "C:\temp\scheduledTaskRun.log"
log -testo "###################################### Nuova esecuzione ######################################" -colore "green" | Out-File $logpath -Append
if ((Test-Path "C:\temp\servizi_attivi.csv") -eq $true){
    if((Test-Path -Path "C:\temp\Archivio") -ne $true){
        log -testo "Cartella archivio non trovata, la creo" -colore "green" | Out-File $logpath -Append
        New-Item -ItemType "directory" -Path "C:\temp\Archivio" | out-null
    }
    $data = Get-Date -Format "ddMMyyyyHHmmss"
    log -testo "sposto il file esistente nell'archivio" -colore "green" | Out-File $logpath -Append
    Move-Item "C:\temp\servizi_attivi.csv" "C:\temp\Archivio\processi_attivi$data.csv"
}

log -testo "creo il file contenente i servizi" -colore "green" | Out-File $logpath -Append
$servizi | Where-Object {$_.Status -eq "Running"} | Export-Csv -Path "C:\temp\servizi_attivi.csv"
$active = @($servizi | Where-Object {$_.Status -eq "Running"}).Count
$stopped = @($servizi | Where-Object {$_.Status -eq "Stopped"}).Count
log -testo "Servizi attivi: $active Servizi stopped: $stopped" -colore "green" | Out-File $logpath -Append