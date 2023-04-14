################################################
## Nome file
# ConfigurazioneClient.ps1
################################################
## Funzioni
# Disabilita il Windows Firewall su tutte le postazioni
# Rinominare il nome computer con CW%DATADIOGGI%
# Importare wallpaper sulle postazioni
# Creazione dell'utente "helpdesk" con password "Admin_%ComputerName%"
# Lista degli account locali e printa a video e file di log il nome, descrizione e data di ultima modifica della psw
# Creazione di un log con nome "%ComputerName% - dataesecuzione.log" con ComputerName, username, data e ora di esecuzione sulla prima riga
# Log da salvare in "C:\Windows\Logs" con traccia dei comandi eseguiti
################################################
## Version History
# v0.1 | Prima versione dello script
################################################
# Autore: Marco - flaam@nebulacorp.xyz
# Data prima stesura: 14/04/2023
# Data ultima modifica: 14/04/2023
# Ultimo autore: Marco - flaam@nebulacorp.xyz
################################################

# Variabili generali
$datadioggi = Get-Date -Format dd-MM-yyyy
$dataora = Get-Date -Format dd-MM-yyyy_HH-mm-ss
$nomecomputer = "CW" + "$datadioggi"
$logfile = "C:\Windows\Logs\$nomecomputer-$dataora.log"

# Funzione di log
function log {
    param ( [Parameter(Mandatory=$true)] [string] $out, [Parameter(Mandatory=$true)][string] $level )
    $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    switch ($level) {
        0 {
                $output = "$date - INFO   | $out";
                break 
          }
        1 {
                $output = "$date - AVVISO | $out";
                break 
          }
    }

    Write-Output $output | Out-File -FilePath $logfile -Append
    return $output;
}

# Log dei dettagli di esecuzione sulla prima riga
log -out "ComputerName: $env:COMPUTERNAME - Utente: $env:USERNAME - Data e ora di esecuzione: $dataora" -level 0

# Abilita il firewall e controlla se è già disabilitato
if (Get-NetFirewallProfile | Where-Object {$_.Enabled -eq "True"}) {5
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    log -out "Il firewall è stato disabilitato" -level 0
}else{
    log -out "Il firewall è già disabilitato" -level 1
}

# Rinomina il computer
Rename-Computer -NewName $nomecomputer
log -out "Il computername è stato cambiato in $nomecomputer" -level 0

# Crea directory del wallpaper
if (!(Test-Path -Path "C:\Wallpaper")) {
    New-Item -ItemType Directory -Path "C:\Wallpaper" | Out-Null
    log -out "La directory C:\Wallpaper è stata creata" -level 0
}else{
    log -out "La directory C:\Wallpaper è già presente sull'host" -level 1
}

# Importa il wallpaper
$url = "https://www.wallpapertip.com/wmimgs/3-30851_hd-wallpaper-4k.jpg"
if (!(Test-Path -Path "C:\Wallpaper\Wallpaper.jpg")) {
    Invoke-WebRequest $url -OutFile C:\Wallpaper\Wallpaper.jpg
    log -out "Il wallpaper è stato scaricato correttamente" -level 0
}else{
    log -out "Il wallpaper è già presente sull'host" -level 1
}

# Verifica presenza dell'utente "helpdesk" e creazione utente con password
if (!(Get-LocalUser -Name helpdesk -ErrorAction SilentlyContinue))  {
    New-LocalUser -Name helpdesk -Password (ConvertTo-SecureString -String Admin_$computername -AsPlainText -Force)
    log -out "L'utente helpdesk è stato creato con successo" -level 0
}else{
    log -out "L'utente helpdesk è già esistente sull'host" -level 1
}

# Lista degli utenti locali con i dettagli richiesti
$localUser = Get-LocalUser
log -out "Lista degli utenti:" -level 0
foreach ($user in $localUser){
    log -out "Utente: $($user.Name) - Descrizione: $($user.Description) - Password modificata il: $($user.passwordLastSet)" -level 0
}

# Richiesta all'utente di riavviare il PC per applicare le modifiche
$confermariavvio = Read-Host "Configurazione completata, vuoi riavviare il PC? (Y/N)"
if ($confermariavvio -eq "Y" -or $confermariavvio -eq "y") {
    log -out "$env:USERNAME ha premuto Y e il PC è stato riavviato" -level 0
    Restart-Computer
}else{
    log -out "$env:USERNAME ha premuto N e il PC non è stato riavviato" -level 1
}