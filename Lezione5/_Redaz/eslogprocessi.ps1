$servizi = Get-Service | Where-Object status -eq "Running" | Sort-Object Name
$dataora = Get-Date -Format dd-MM-yyyy_HH-mm-ss
$path = "C:\Script\Archivio\servizi_attivi" + "_$dataora" + ".csv"

if (Test-Path "C:\Script\servizi_attivi.csv"){

    if (Test-Path "C:\Script\Archivio") {

    Move-Item -Path "C:\Script\servizi_attivi.csv" -Destination $path
    $servizi | Export-Csv "C:\Script\servizi_attivi.csv"

    }else{

    New-Item -Path "C:\Script\Archivio" -ItemType Directory
    Move-Item -Path "C:\Script\servizi_attivi.csv" -Destination $path
    $servizi | Export-Csv "C:\Script\servizi_attivi.csv"

    }

} else {
    $servizi | Export-Csv "C:\Script\servizi_attivi.csv"
}

$pathlog = "C:\Temp\ScheduledTaskRun.log"
$datalog = Get-Date -Format dd-MM-yyyy
$oralog = Get-Date -Format HH:mm:ss
$numeroserviziR = (Get-Service | Where-Object status -eq "Running").count
$numeroserviziS = (Get-Service | Where-Object status -eq "Stopped").count

Add-Content -path $pathlog "-----------------------------------------------------------"
Add-Content -path $pathlog "# Esecuzione dello script in data: $datalog ore $oralog" 
Add-Content -path $pathlog "#   Servizi attivi: $numeroserviziR"
Add-Content -path $pathlog "#   Servizi fermi: $numeroserviziS"