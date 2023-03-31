function LOG {

    param ($Messaggio,$Colore)

    $colore = Read-Host "colore"

    switch ($colore)
    { 
     "green" { Write-Host "INFO |" $messaggio -ForegroundColor GREEN }
             
     "yellow" { Write-Host "WARNING |" $messaggio -ForegroundColor YELLOW }
         
     "red" { Write-Host "ERROR |" $messaggio -ForegroundColor RED }
        
     default { Write-Host $messaggio -ForegroundColor WHITE }   
    }

}

$file = "C:\log.txt"
$data = Get-Date -Format "dd/MM/yyyy HH:mm" 
$data = "Inizio esecuzione " + $data

LOG -messaggio $data -colore $colore
