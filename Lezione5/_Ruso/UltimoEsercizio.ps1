<# Creazione task schedulata che:
-Effettua una estrazione dei servizi attivi (running) sulla postazione salvandoli su una variabile
-Salvare in un file csv i servizi atttivi, ordinati per nome processo, nel percorso C:\Script\servizi_attivi.csv

Se nel percorso è già presente il file bisogna creare una sottocartella in Script\Archivio, 
spostare il file processi_attivi in Archivio e rinominarlo con servizi_attivi$DATAORA

salvare in un file C:\windows\temp\Scheduledtaskrun.log un log contenente data e ora di esecuzione dello script
+ numero totale di servizi in running e in stopped.

Ad ogni esecuzione le informazioni dovranno essere aggiunte #>

$dataora = Get-Date -Format "ddMMyyy_HHmm"
$Path1 = "C:\Script\servizi_attivi.csv"
$Path2 = "C:\Script\Archivio"
$Path3 = "C:\Script\Archivio\servizi_attivi"
$ServiziAtt = Get-Service | Where-Object Status -eq 'Running'  | Sort-Object -Property NAME | Select-Object NAME, STATUS |Format-Table -Property NAME, STATUS -AutoSize

$log = "C:\Windows\Temp\ScheduledTaskRun.log"



if (Test-Path $log)
    { 
        $datalog = Get-Date -Format "ddMMyyyy_HHmm"

    }
else
    {
        
    }



if (Test-Path $Path1) 
{
    if (Test-Path $Path2)
    { 

        $Rinomina = $Path3 +"_$dataora"+".csv"
        Move-Item -Path $Path1 -Destination $Rinomina 
        $ServiziAtt | Export-Csv $Path1
 
    }
    else
    {

        $Rinomina = $Path3 +"_$dataora"+".csv"
        New-Item -ItemType Directory -Path $Path2 
        Write-Host $Path1 "Esiste già, il file verrà spostato in archivio, adesso verranno tutti salvati qui dentro ed i file verranno rinominati aggiungendo la data"
        Move-Item -Path $Path1 -Destination $Rinomina
        $ServiziAtt | Export-Csv $Path1
 
    }
}
else 
{

    $ServiziAtt | Export-Csv $Path1

}
