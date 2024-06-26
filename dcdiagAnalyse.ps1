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

foreach ($line in $dcDiagOutput) {
    if ($line -match "\s+\.+\s([A-Za-z0-9]+( [A-Za-z0-9]+)+)\.") {
        $line = $line.Substring($line.IndexOf("Test ")+5)
        $line = $line.Substring(0, $line.Length-1)
        $line = $line.Replace(" ", " - ")
        if ($line.Substring(0, $line.IndexOf(" ")) -in $testList)
        {
            Write-Host $line
        }
    }
}