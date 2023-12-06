cd $PSScriptRoot
$timesStr, $distancesStr = Get-Content "data.txt"
$times = $timesStr.Split(":")[1].Trim() -split "\s+" | % { [int]$_}
$distances = $distancesStr.Split(":")[1].Trim() -split "\s+" | % { [int]$_}
$count = $times.Count

$result = 1
for($i = 0; $i -lt $count; $i++)
{
    $time = $times[$i]
    $distanceRecord = $distances[$i]
    $wins = 0
    for($hold = 0; $hold -le $time; $hold++)
    {
        $speed = $hold
        $timeLeft = $time - $hold
        $distance = $timeLeft * $speed
        if ($distance -gt $distanceRecord) {
            $wins++
        }
    }
    $result *= $wins
}

Write-Host $result