#laboratorio finale
#data da utilizzare per la rinomina del Computer
$datadioggi = Get-Date -Format yyyyMMdd
$nomecomputer = "CW" + "$datadioggi"
$logfile = "C:\Windows\Logs\$nomecomputer-$datadioggi" + ".log"
if (Test-Path "HKLM:\Software\RETI") {
        Write-Host "Lo script è già stato eseguito."
}
else {

        function log {
                param ( [Parameter(Mandatory = $true)] [string] $messaggio, [Parameter(Mandatory = $true)][string] $log )
                $date = Get-Date -Format "dd/MM/yyyy_HH:mm:ss"
                switch ($log) {
                        info {
                                #log info 
                                $output = "$date - INFO    | $messaggio";
                                break
                        }
                        warn {
                                #log warning
                                $output = "$date - WARNING | $messaggio";
                                break
                        }
                        err {
                                #log error
                                $output = "$date - ERROR   | $messaggio";
                                break
                        }
                        null {
                                #log null
                                $output = "$messaggio"; 
                                break
                        }
                }
                Write-Output $output | Out-File -FilePath $logfile -Append
                return $output;
        }
        #Primo messaggio di log
        log -messaggio "--------------------------------Script esegito il $datadioggi --------------------------------" -log null

        #1)Rinomina il computer
        try {
                Rename-Computer -NewName $nomecomputer
                log -messaggio "Il computername è stato cambiato in $nomecomputer" -log info
        }
        catch {
                log -messaggio "Impossibile cambiare il nome del computer causa: $_" -log err
        }
        #2)password admin
        try {
                $password = "Admin_" + $nomecomputer
                Set-LocalUser -Name "Administrator" -Password (ConvertTo-SecureString -String $password -AsPlainText -Force)
                log -messaggio "La Password di Admin è stata cambiata" -log info
        }
        catch {
                log -messaggio "Impossibile creare il gruppo e spostare l'utente al suo interno causa: $_" -log err
        }
        #3)Blocco cambio Password Administrator
        #Set-LocalUser -Name "Administrator" -UserMayChangePassword $false
        #log -messaggio "E'impostato il blocco del cambio password per admin" -log info

        #4)Nuovo utente
        try {
                $passwordospite = "Password1"
                New-LocalUser -Name "Ospite" -Password (ConvertTo-SecureString -String $passwordospite -AsPlainText -Force) -ErrorAction Stop
                log -messaggio "E' stato creato l'utente Ospite" -log info
        }
        catch {
                log -messaggio "Impossibile creare l'utente ospite causa: $_" -log err
        }
        #5)Nuovo gruppo Utenti Locali
        try {
                New-LocalGroup -Name "Utenti Locali" -ErrorAction Stop
                log -messaggio "E' stato creato il gruppo utenti locali" -log info
        }
        catch {
                log -messaggio "Impossibile creare il gruppo causa: $_" -log err
        }
        #Spostamento Admin in Utenti Locali
        try {
                Add-LocalGroupMember -Group "Utenti Locali" -Member "Administrator" -ErrorAction Stop
                log -messaggio "E' stato creato il gruppo utenti locali ed Admin è stao spestato al suo interno " -log info
        }
        catch {
                log -messaggio "Impossibile spostare l'utente Admin al suo interno causa: $_" -log err
        }

        #6)Chiave di registro in HKLM\Software\Reti
        try {
                $dataora = Get-Date -Format ddMMyyyy_HH:mm
                New-Item -Path HKLM:\Software -Name RETI -Value "$dataora" –Force -ErrorAction Stop
                log -messaggio "É stata creata la chiave di registro" -log info
        }
        catch {
                log -messaggio "Impossibile creare la chiave di registro causa: $_" -log err
        }

        #7)Rimuove tutti i Dati dalla cartelle C:\Windows\Temp
        try {
                $files = Get-ChildItem -Path "C:\Windows\Temp\*" -File -Recurse
                foreach ($file in $files) {
                        if (Test-Path -Path $file.FullName -ErrorAction SilentlyContinue) {
                                # Il file è aperto, quindi non può essere eliminato
                                log -messaggio "Il file $($file.FullName) è aperto e non può essere eliminato." -log err
                        }
                        else {
                                Remove-Item -Path $file.FullName -ErrorAction Stop
                        }
                }
                log -messaggio "Sono stati cancellati i file in C:\Windows\Temp." -log info
        }
        catch {
                log -messaggio "Non è stato possibile cancellare i file a causa dell'errore: $($_.Exception.Message)" -log err
        }
        #8)Installazione notepad++
        try {
                Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.3/npp.8.5.3.Installer.x64.exe" -OutFile "C:\Program Files\notepad.exe"
                Start-Process -FilePath "C:\Program Files\notepad.exe" -ArgumentList "/S"
                log -messaggio "É stato installato il programma Notepad++" -log info
        }
        catch {
                log -messaggio "Impossibile installare Notepad causa: $_" -log err
        }
        log -messaggio "-------------------------------------------------------------------------------------------" -log null
}
