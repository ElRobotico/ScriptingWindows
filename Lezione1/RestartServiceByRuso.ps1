<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION : Restart Spooler Service

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>

<# 1st Method #>
$Servizio = Spooler
Restart-Service $Servizio

<# 2nd Method #>
Get-Service -Name $Servizio | Restart-Service