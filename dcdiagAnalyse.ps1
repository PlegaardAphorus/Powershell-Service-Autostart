## Regex ......................... beinhaltet [bestanden / fehlgeschlagen]
## Array: "[NAME] - [STATUS]"

$testList = @(
    "Connectivity"
    "Advertising"
    "FrsEvent"
    "DFSREvent"
    "SysVolCheck"
    "KccEvent"
    "MachineAccount"
    "NetLogons"
    "Replications"
    "RidManager"
    "Services"
)

$dcDiagOutput = Get-Content "..\dcdiag output.txt"

$allTests = @()
$testName = @()

foreach ($line in $dcDiagOutput) {
    if ($line -match "Starting test: [A-Za-z]+") {
        $allTests += $line.Substring($line.IndexOf(":")+2)
    }
}

foreach ($name in $allTests) {
    if ($name -in $testList) {
        $testName += $name
    }
}

Write-Host $testName