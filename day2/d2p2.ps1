cd $PSScriptRoot
$content = Get-Content "input.txt"

$sum = 0
foreach($line in $content)
{
#    $s = "Game 67: 15 green, 7 blue, 1 red; 8 green, 7 blue; 5 blue, 1 red, 4 green; 2 green, 9 blue; 1 red, 6 blue"
    $s = $line
    $s -match "Game (\d+): (.*)"
    $id = $Matches[1]
    $rest = $Matches[2]

    $maxr = 0
    $maxg = 0
    $maxb = 0

    $parts = $rest.Split(";")
    foreach($part in $parts)
    {
        $subparts = $part.Split(",")
        foreach($subpart in $subparts)
        {
            [int]$count, $color = $subpart.Trim().Split(" ")
            switch($color)
            {
                "red" { if ($count -gt $maxr) { $maxr = $count } }
                "green" { if ($count -gt $maxg) { $maxg = $count } }
                "blue" { if ($count -gt $maxb) { $maxb = $count } }
            }        

        }
    }

    $sum += $maxr * $maxg * $maxb
}

write-host "-----"
Write-host $sum


