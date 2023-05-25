#############
#lab.ps1
#autore:               Gruppo 0 
#data creazione:       22/05/2023
#data ultima modifica: 24/05/2023
#versione: 1.2
#############
#Funzionalità dello script: 
#Rinomina il computer in CW%DATADIOGGI%
#Imposta la password dell'amministratore locale a "Admin_%COMPUTERNAME%"
#Disabilita la richiesta di cambio password per l'utente amministratore locale
#Crea un utente locale ospite con password "Password01"
#Crea il gruppo "Utenti Locali" e vi inserisce l'utente "Administrator"
#Aggiunge una chiave di registro nel percorso "HKLM:\SOFTWARE\Reti" contenente data e ora di esecuzione dello script
#Elimina il contenuto della cartella C:\Windows\Temp
#Installa Notepad++ se non è già installato in modo silent
#Logga ciò che avviene durante l'esecuzione dello script nel file C:\Windows\Logs\%ComputerName%-dataesecuzione.log
#############
#Requisiti per l'esecuzione:
#Lo script deve essere eseguito con i privilegi di amministratore 
#############

#DICHIARAZIONE VARIABILI
$nuovoNome = "CW" + $(Get-Date -Format ddMMyyyy)
$logfile = "C:\Windows\Logs\$nuovoNome-$(Get-Date -Format ddMMyyy-hhmmss)"
$newUser = "ospite"
$newUserPsw = "Password01"
$groupName = "Utenti Locali"
$regpath = "HKLM:\Software\Reti"
$regKey = "lastRunTime"
$folderPath = "C:\Windows\Temp"
$nppUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.3/npp.8.5.3.Installer.x64.exe"



#FUNZIONE DI LOGGING UTILIZZATA NELLO SCRIPT
#Descrizione: funzione che prende in input una stringa e il livello dell'elemento che si vuole loggare:
# 0: informazioni
# 1: warning
# 2: error
# se viene specificato un livello non previsto la funzione scrive solamente ciò che le è stato dato in input con un timestamp aggiuntivo
#Richiede: che nella variabile $logfile sia specificato il path di un file in cui salvare il log 
function log {
    param ( [Parameter(Mandatory=$true)] [string] $out, [Parameter(Mandatory=$true)][int16] $level )
    $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    switch ($level) {
        0 {    #livello info
                $output = "$date - INFO | $out";
                break 
          }
        1 {     #livello warning
                $output = "$date - WARNING | $out";
                break 
          }
        2 {     #livello error
                $output = "$date - ERROR | $out";
                break
          }
        Default {
                #tutti gli altri valori della variabile level finiscono qui
                $output = "$date | $out";
                }
    }

    #scrivo sia a terminale che all'interno del file di log specificato
    Write-Output $output | Out-File -FilePath $logfile -Append
    return $output;
}

#verifico che l'hive del registro creata nello script non esista, se esiste lo script è già stato eseguito, di conseguenza esco
if(Test-Path $regpath\$regKey){
    exit
}

log -out "### AVVIO ESECUZIONE - Hostname: $ENV:ComputerName UserName: $ENV:UserName ###" -level 4

#Rinomino il computer come richiesto
log -out "Rinomino il pc, hostname attuale $ENV:ComputerName - nuovo nome $nuovoNome" -level 0
#sfrutto il try-catch per loggare eventuali errori nell'esecuzione dell'istruzione
try{ 
    Rename-Computer -NewName $nuovoNome -ErrorAction Stop
}
catch {
    log -out "Errore durante il cambio di hostname: $_" -level 2
}

#cambio password utente Administrator
log -out "Imposto la password dell'utente amministratore locale" -level 0
if(!(Get-LocalUser -Name "Administrator" )){
    #verifico l'esistenza dell'utente administrator (dovrebbe esistere di default ma non si sa mai...)
    log -out "Utente Administrator non presente!" -level 2
}else{
    #se esiste cambio la password
    $password = "Admin_$nuovoNome"
    log -out "Reimpostazione della password, nuova password: $password" -level 0
    try {
        Set-LocalUser -Name "Administrator" -Password (ConvertTo-SecureString $password -AsPlainText -Force) -ErrorAction Stop | Out-Null }
    catch {
        log -out "Impossibile reimpostare la password per l'utente Administrator, errore: $_" -level 2
    }
}

#Disabilito la richiesta di cambio password per administrator
log -out "Disabilito la richiesta di cambio password per l'utente Administrator" -level 0
try{
    Set-LocalUser -Name  "Administrator" -PasswordNeverExpires $true -ErrorAction Stop | Out-Null
}catch{
    log -out "Impossibile settare la proprietà richiesta, errore: $_" -level 2
}

#Creo utente ospite
#Verifica dell'esistenza dell'utente ospite, se non esiste lo creo
log -out "Verifico la presenza dell'utente $newUser" -level 0
if(!(Get-LocalUser -Name $newUser)){
    log -out "Utente non presente, lo creo" -level 0
    #se l'utente non esiste lo creo sfruttando try-catch per l'error handling
    try {New-LocalUser -Name $newUser -Password (ConvertTo-SecureString $newUserPsw -AsPlainText -Force) -ErrorAction Stop | Out-Null }
    catch {
        log -out "Impossibile creare l'utente $newUser, errore: $_" -level 2
    }
}else{
    #se esiste già salto la creazione dell'utente
    log -out "Utente gia' presente, salto la creazione" -level 0
}

#Creare il gruppo "Utenti Locali" e inserire l'utente Administrator.

log -out "Verifico la presenza del gruppo $groupName" -level 0
if(!(Get-LocalGroup -Name $groupName)){
    log -out "Gruppo non presente, lo creo" -level 0
    #se il gruppo non esiste lo creo sfruttando try-catch per l'error handling
    try {New-LocalGroup -Name $groupName -ErrorAction Stop | Out-Null }
    catch {
        log -out "Impossibile creare il gruppo $groupName, errore: $_" -level 2
    }
   
}else{
    #se esiste già salto la creazione del gruppo 
    log -out "Gruppo gia' presente, salto la creazione" -level 0
}
    #facciamo un altro check sull'esistenza del gruppo per evitare errori stupidi se l'operazione sopra è fallita o per qualche strano motivo non ho trovato il gruppo
if(!(Get-LocalGroup -Name $groupName)){
       log -out "Gruppo non esistente, non posso aggiungere l'utente" -level 2
}else{
    try{
        Add-LocalGroupMember -Group $groupName -Member "Administrator" -ErrorAction Stop | Out-Null
    }catch{
        log -out "Impossibile aggiungere l'utente administrator al gruppo $groupName, errore $_" -level 2
    }
}

#Aggiunge una chiave di registro nel percorso HKLM\Software\Reti contenente data e ora di esecuzione dello script.

log -out "Aggiungo una chiave di registro nel percrso HKLM\Software\Reti con data e ora di esecuzione dello script" -level 0
if(!(Test-Path $regpath)){
    log -out "Hive non esistente, creo il path" -level 0
    try {
        New-Item -Path $regpath -force -ErrorAction Stop
    }
    catch {
        log -out "Impossibile creare hive, errore $_" -level 2
    }
}
#con l'hive creato posso creare la chiave
log -out "Creo la chiave di registro" -level 0
try {
    New-ItemProperty -LiteralPath $regpath -Name $regKey -Value $(Get-Date -Format ddMMyyyy-HHmmss) -PropertyType String -Force -ErrorAction Stop
}
catch{
    log -out "Impossibile creare la chiave $regpath\$regKey, errore: $_" -level 2
}

#Eliminare il contenuto della cartella C:\Windows\Temp

log -out "Elimino il contenuto della cartella $folderPath" -level 0
$files = Get-ChildItem -Path $folderPath
foreach ($file in $files) {
    try {
        Remove-Item $folderPath\$file -Recurse -Force -ErrorAction Stop
    }
    catch {
        log -out "Impossibile eliminare il file $file, errore: $_" -level 2
    }
    
}

#Installare Notepad++ (https://notepad-plus-plus.org/download) in maniera silent (senza iterazione dell'utente).
log -out "Verifico che notepad++ non sia installato" -level 0
$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
$installed = $false
#itero sulle chiavi di registro delgi uninstaller per verificare che il programma non sia presente
foreach($obj in $InstalledSoftware){
    if ($obj.GetValue('DisplayName') -like "Notepad++ *"){
        $installed = $true
    }
}
if (!$installed){
    if(!(Test-Path "C:\Windows\Temp\npp.exe")){
        #se non esiste scarico l'installer
        log -out "Scarico l'installer" -level 0
        try { 
            Invoke-WebRequest $nppUrl -OutFile "C:\Windows\temp\npp.exe" -ErrorAction Stop
            }
        catch {
            log -out "Impossibile scaricare il file, errore: $_" -level 2
        }
    }else{
        log -out "Installer esistente, salto il download" -level 1
    }
    
    log -out "Eseguo l'installazione" -level 0
    try {
        Start-Process -Wait "C:\Windows\temp\npp.exe" -ArgumentList "/S /qn" -ErrorAction Stop
    }
    catch {
        log -out "Impossibile installare npp, errore: $_" -level 2
    }
}else{
    log -out "Notepad già installato, installazione saltata" -level 1
    
}


