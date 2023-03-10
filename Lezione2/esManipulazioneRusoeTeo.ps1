<# Selezionare una directory di un file #>

$Directory = "C:\Windows\System32\drivers\etc\lmhosts.sam"


<# Trovare la lunghezza della directory per individuare poi l'ultimo file qui presente #>

$Grandezza = $Directory.Split("\").Count
$Grandezza = $Grandezza -1


<# Visualizzare l'ultimo file presente nella directory #>

$Directory = $Directory.Split("\")[$Grandezza]
Write-Host $Directory