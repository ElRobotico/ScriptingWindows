$path = "C:\temp"
$objects = Get-ChildItem -Path $path
$counter = 0
ForEach ($object in $objects){
$counter = $counter + 1
$chars = $object.Name | Measure-Object -Character
Write-Host "I caratteri del file $($object.Name) sono $($chars.Characters)"
}
Write-Host "Numero di files nella cartella $($path): $($counter)"