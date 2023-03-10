<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION : Create a CSV list with the first 20 processes in execution, sort them descending in order of ID;
            Then, there's a script that create a scheduled task working every 10 min and it execute the first script done.

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>

<# Creazione della variabile dentro la quale inserire la data di oggi #>
$DatadiOggi = Get-Date -Format "ddMMyyyy"

<# Aggiungere alla variabile quanto richiesto dall'esercitazione #> 
$DatadiOggi = $DatadiOggi + "_Process.csv"

<# Creazione variabile di exportpath per un utilizzo rapido #>
$path = "C:\temp"

<# Script per prelevare i primi 20 processi porli in ordine descrente in base all'id ed esportare il risultato in un file csv #>
 Get-Process | Select-Object -First 20 | Sort-Object -Descending ID | Export-Csv -Path "$path\$DatadiOggi" 