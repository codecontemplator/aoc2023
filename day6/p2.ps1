cd $PSScriptRoot
$timesStr, $distancesStr = Get-Content "data.txt"
$timesStr = $timesStr.Replace(" ", "")
$distancesStr = $distancesStr.Replace(" ", "")
$times = $timesStr.Split(":")[1].Trim() -split "\s+" | % { [int64]$_}
$distances = $distancesStr.Split(":")[1].Trim() -split "\s+" | % { [int64]$_}
$count = $times.Count

$time = $times[0]
$distanceRecord = $distances[0]
[int64]$wins = 0
#for($hold = 0; $hold -le $time; $hold++)
#{
    # $time * $hold - $hold * $hold > $dr          & 0 <= $hold <= $time
    # $time * $hold - $hold * $hold - $dr > 0      & 0 <= $hold <= $time
    # -1 *hold^2 + $time * hold - dr = 0 
    # a = -1, b = time, c = -dr

    # $hold = -$time +- sqrt( $time^2 - 4 * (-1) * (-dr) )


$h1 = [math]::Ceiling( (-$time + [math]::Sqrt($time*$time - 4 * (-1) * (-$distanceRecord))) / (-2) )
$h2 = [math]::Ceiling( (-$time - [math]::Sqrt($time*$time - 4 * (-1) * (-$distanceRecord))) / (-2) )

Write-Host ($h2 - $h1)

#}

Write-Host  $h1, $h2