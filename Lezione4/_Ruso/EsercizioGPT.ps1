<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION :

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>


# Elencare il contenuto della cartella c:windows\temp e stampare quanti caratteri ha ogni file

Get-ChildItem C:\Windows\Temp | ForEach-Object { 
    Write-Host $_.Name.Length $_.Name 
}




# Elencare i servizi e colorarli in rosso se posti in stato stopped oppure in verde se in running

Get-Service | ForEach-Object {
    $serviceName = $_.Name
    $serviceStatus = $_.Status
    if ($serviceStatus -eq "Running") {
        Write-Host $serviceName -ForegroundColor Green
    } else {
        Write-Host $serviceName -ForegroundColor Red
    }
}