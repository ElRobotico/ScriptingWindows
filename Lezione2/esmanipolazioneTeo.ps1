#Matteo Redaelli

$path = "C:\Windows\System32\drivers\etc\lmhosts.sam\pippo"
$var = $path.Split("\").Count - 1
$var2 = $var - 1
$final = $path.Split("\")[$var2]
Write-Host $final