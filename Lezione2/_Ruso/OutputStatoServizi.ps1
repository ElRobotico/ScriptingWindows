<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION : 

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>

<# Output formato tabella ordinato per stato #> 

Get-Service | Sort-Object -Property STATUS


<# uguale al precedente ma specificando le proprietà che vogliamo utilizzare #>

Get-Service | Sort-Object STATUS | Format-Table -Property NAME, STATUS -AutoSize


<# Filtra quelli in stato running #>

Get-Service | Where-Object { $_.Status -eq 'Running' }

Get-Service | Where-Object { Status -eq 'Running' }
