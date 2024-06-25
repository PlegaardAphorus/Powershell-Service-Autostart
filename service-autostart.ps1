Write-Host "Überprüfung gestartet"

$services = Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Where-Object {$_.Status -eq "Stopped"}

if ($services.Length -ge 1) {
    Write-Host "Name aller Dienste die nicht gestartet wurden:"
    
    for ($i = 0; $i -lt $services.Length; $i++) {
        Write-Host $services[$i].Name
    }
    Write-Host ""
    for ($j = 0; $j -lt $services.Length; $j++) {
        try {
            Start-Service -InputObject $services[$j] -ErrorAction Stop
        }
        catch {
            Write-Host $_.Exception.Message
        }
    }
}
else {
    Write-Host "Alle Dienste wurde Ordnungsgemäß gestartet."
}

Write-Host ""
Write-Host "Die Überprüfung wurde beendet."