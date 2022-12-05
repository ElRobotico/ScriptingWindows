$services = Get-Service
ForEach ($service in $services) {
    Write-Host $service.Name "--" $service.status
}
Write-Host Services count: $services.count