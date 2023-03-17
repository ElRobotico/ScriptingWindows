#Get-Service | Sort-Object -Property Status
#Get-Service | Sort-Object Status | Format-Table -Property Name,Status -AutoSize
Get-Service | Where-Object{ $_.Status -eq 'Running' }