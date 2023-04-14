#############
#Test.ps1
#autore:               B1gpav
#data creazione:       14/04/2023
#data ultima modifica: 14/04/2023
#############
#Funzionalità dello script: 
#Disabilita il Windows Firewall
#Rinomina il computer in CW%DATADIOGGI%
#Verifica che la cartella c:\Wallpaper esiste, se esiste verifica l'esistenza del file WallPaper.jpg, se non esiste la scarica da https://www.wallpapertip.com/wmimgs/3-30851_hd-wallpaper-4k.jpg
#Verifica l'esistenza dell'utente helpdesk, se non esiste lo crea e imposta come password Admin_%ComputerName%
#Elenca gli utenti locali, la loro descrizione e la data dell'ultima modifica della password
#Logga ciò che avviene durante l'esecuzione dello script nel file C:\Windows\Logs\%ComputerName%-dataesecuzione.log e inserisce come intestaizone l’hostname della macchina, il nome dell’utente, la data e l’ora di esecuzione
#############
#Requisiti per l'esecuzione:
#Lo script deve essere eseguito con i privilegi di amministratore 
#############

#DICHIARAZIONE VARIABILI
$nuovoNome = "CW" + $(Get-Date -Format ddMMyyyy)
$logfile = "C:\Windows\Logs\$nuovoNome-$(Get-Date -Format ddMMyyy-hhmmss)"
$wallpaperDir = "C:\WallPaper"
$wallpaperUrl = "https://www.wallpapertip.com/wmimgs/3-30851_hd-wallpaper-4k.jpg"
$helpDeskUser = "helpdesk"

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

log -out "### AVVIO ESECUZIONE - Hostname: $ENV:ComputerName UserName: $ENV:UserName ###" -level 4
#DISABILITO IL FIREWALL
#ottengo lo stato attuale del firewall per ogni profilo
$fwState = (Get-NetfirewallProfile | Select-Object Name, Enabled)
foreach ($status in $fwState) {
    if ($status.Enabled){
        #se per ogni profilo il firewall è attivo procedo con la disattivazione
        log -out "Firewall attivo per le reti di tipo $($status.Name), lo disattivo" -level 0 
        #utilizzo un try-catch per poter loggare eventuali errori che dovessero insorgere durante la disattivazione del firewall
        try {Set-NetFirewallProfile -Profile $status.Name -Enabled False -ErrorAction Stop}
        catch {
            log -out "Impossibile disattivare il firewall per le reti di tipo $($status.Name), errore: $_" -level 2
        }
    } else{
        #se il firewall è già disattivato salto alla parte successiva
        log -out "Firewall gia' disattivo per le reti di tipo $($status.Name), proseguo" -level 1
    }
}

#Rinomino il computer come richiesto
log -out "Rinomino il pc, hostname attuale $ENV:ComputerName - nuovo nome $nuovoNome" -level 0
#come sopra sfrutto il try-catch per loggare eventuali errori nell'esecuzione dell'istruzione
try{ Rename-Computer -NewName $nuovoNome -ErrorAction Stop }
catch {
    log -out "Errore durante il cambio di hostname: $_" -level 2
}

#Controllo dell'esistenza della cartella wallpaper e eventuale download dei file
log -out "impostazione sfondo" -level 0
#controllo se la cartella esiste
if (!(Test-Path -Path $wallpaperDir)){
    #se non esiste la creo
    log -out "Creo la cartella $wallpaperDir" -level 0
    #sruttando anche qui il try-catch per eventuali errori
    try {New-Item $wallpaperDir -ItemType Directory -ErrorAction Stop}
    catch {
        log -out "Impossibile creare la cartella $wallpaperDir, errore: $_" -level 2
    }
}else{
    log -out "Cartella $wallpaperDir presente, salto la creazione" -level 1
}
#verifico l'esistenza del file wallpaper
log -out "Verifico l'esistenza del file" -level 0
if (!(Test-Path -Path "$wallpaperDir\WallPaper.jpg")){
    #se non esiste lo scarico
    log -out "Scarico lo sfondo" -level 0
    try { Invoke-WebRequest $wallpaperUrl -OutFile "$wallpaperDir\WallPaper.jpg" -ErrorAction Stop}
    catch {
        log -out "Impossibile scaricare il file, errore: $_" -level 2
    }
}else{
    #se esiste skippo
    log -out "File WallPaper.jpg esistente, salto il download" -level 1
}

#Verifica dell'esistenza dell'utente helpdesk, se non esiste lo creo
log -out "Verifico la presenza dell'utente $helpDeskUser" -level 0
if(!(Get-LocalUser -Name $helpDeskUser )){
    log -out "Utente non presente, lo creo" -level 0
    #se l'utente non esiste lo creo sfruttando try-catch per l'error handling
    try {New-LocalUser -Name $helpDeskUser -Password (ConvertTo-SecureString "Admin_$nuovoNome" -AsPlainText -Force) -ErrorAction Stop | Out-Null }
    catch {
        log -out "Impossibile creare l'utente $helpDeskUser, errore: $_" -level 2
    }
}else{
    #se esiste già salto la creazione dell'utente
    log -out "Utente gia' presente, salto la creazione" -level 0
}

#Ottengo gli utenti locali e stampo il nome, la descrizione e la data dell' ultima modifica della password 
$localUser = Get-LocalUser
log -out "Ottengo tutti gli utenti e la descrizione" -level 0
foreach ($user in $localUser){
    #stampa sia su log che su terminale
    log -out "Utente: $($user.Name) - Descrizione: $($user.Description) - Password Impostata l'ultima volta il: $($user.passwordLastSet)" -level 0
}
