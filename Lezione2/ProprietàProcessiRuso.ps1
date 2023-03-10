<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION :

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>
<# Ottenere informazioni sui processi in esecuzione #> 

Get-Process | Select-Object -Property Name


<# Ottenerle in formato lista #>

Get-Process | Format-List -Property Name, ID


<# Ottenerle in formato tabella #>

Get-Process | Format-Table -Property Name, ID