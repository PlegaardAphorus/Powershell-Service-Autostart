Write-Host "Überprüfung gestartet"

$exclusion = Get-Content "exclusionlist.txt" | Select-Object -Skip 1
$services = Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Where-Object {$_.Status -eq "Stopped"} | Where-Object {$_.DisplayName -notmatch "Google"} | Where-Object {$_.DisplayName -notin $exclusion}

if ($services.Count -ge 1) {
    Write-Host "Name aller Dienste die nicht gestartet wurden:"
    for ($i = 0; $i -lt $services.Count; $i++) {
        
        Write-Host $services[$i].Name
    }
    Write-Host ""
    for ($j = 0; $j -lt $services.Count; $j++) {
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

Write-Host "Die Überprüfung wurde beendet."
