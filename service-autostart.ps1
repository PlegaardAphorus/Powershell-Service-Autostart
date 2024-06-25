Write-Host "Überprüfung gestartet"

$services = Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Where-Object {$_.Status -eq "Stopped"}

if ($services.Length -ge 1) {
    Write-Host "Name aller Dienste die nicht gestartet wurden:"
    
    for ($i = 0; $i -lt $services.Length; $i++) {
        Write-Host $services[$i].Name
    }

}
else {
    Write-Host "Alle Dienste wurde Ordnungsgemäß gestartet."
}
