<# -----------------------------------------------------------------------------

                                SCRIPT IN WINDOWS

    FUNCTION : List contents from C:\Winwdows folder & convert data into an HTML page

        WRITER : Emanuele Caruso

            PUBLISHED IN : 10/03/2023

                LAST UPDATE : 10/03/2023


!! USE THE CODE AT YOUR RISK, ALL RIGHTS ARE AT THE PRODUCER, NOT SHARE OR RUSO WILL FIND AND PUNISH YOU !!

----------------------------------------------------------------------------- #>

$Directory = "C:\Windows"
Get-ChildItem $Directory | Select-Object Name |ConvertTo-Html | Out-File "C:\Users\user\Desktop\WindowsDIR.html"
