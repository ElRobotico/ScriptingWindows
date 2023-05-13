Add-Type -AssemblyName System.Windows.Forms

# Crea la finestra
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Estrazione log di Windows Defender"
$Form.Size = New-Object System.Drawing.Size(500, 220)

# Crea le etichette
$LogNumberLabel = New-Object System.Windows.Forms.Label
$LogNumberLabel.Location = New-Object System.Drawing.Point(20, 20)
$LogNumberLabel.Size = New-Object System.Drawing.Size(150, 25)
$LogNumberLabel.Text = "Numero di log totali da estrarre (dal più recente):"
$Form.Controls.Add($LogNumberLabel)

$PathLabel = New-Object System.Windows.Forms.Label
$PathLabel.Location = New-Object System.Drawing.Point(20, 65)
$PathLabel.Size = New-Object System.Drawing.Size(150, 25)
$PathLabel.Text = "Percorso di salvataggio:"
$Form.Controls.Add($PathLabel)

$PathLabel2 = New-Object System.Windows.Forms.Label
$PathLabel2.Location = New-Object System.Drawing.Point(170, 85)
$PathLabel2.Size = New-Object System.Drawing.Size(150, 25)
$PathLabel2.Text = "(Esempio C:\Windows\Log)"
$Form.Controls.Add($PathLabel2)

# Crea i campi di testo
$LogNumberBox = New-Object System.Windows.Forms.TextBox
$LogNumberBox.Location = New-Object System.Drawing.Point(170, 20)
$LogNumberBox.Size = New-Object System.Drawing.Size(300, 25)
$Form.Controls.Add($LogNumberBox)

$PathBox = New-Object System.Windows.Forms.TextBox
$PathBox.Location = New-Object System.Drawing.Point(170, 60)
$PathBox.Size = New-Object System.Drawing.Size(300, 25)
$Form.Controls.Add($PathBox)

# Crea il pulsante
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(190, 120)
$Button.Size = New-Object System.Drawing.Size(100,50)
$Button.Text = "ESEGUI"
$Form.Controls.Add($Button)

# Aggiunge l'azione al pulsante
$Button.Add_Click({
    $lognumber = $LogNumberBox.Text
    $path = $PathBox.Text
    $date = Get-Date -Format dd-MM-yyyy_HH-mm-ss
    $filename = "\log_" + $date + ".txt"
    $finalpath = $path + $filename

    #estrazione dei log
    try {
        Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" -MaxEvents $lognumber | Format-List | Out-File $finalpath
        [System.Windows.Forms.MessageBox]::Show("Il file è stato salvato in $finalpath", "Estrazione completata")
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Errore: " + $_.Exception.Message, "Errore")
    }
})

# Mostra la finestra
$Form.ShowDialog() | Out-Null