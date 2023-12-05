using namespace System.Collections.Generic

cd $PSScriptRoot
$rows = Get-Content "data.txt"
[int64]$sum = 0
$ri = 0
$cardCount = $rows | % { 1 }
foreach ($row in $rows) {
    $row -match "^Card\s+(\d+):(.*?)\|(.*)$" | Out-Null
    $wins = $Matches[2].Trim() -split "\s+" | % { [int]$_ }
    $mine = $Matches[3].Trim() -split "\s+" | % { [int]$_ }
    $winsSet = [HashSet[int]]::new([int[]]$wins)
    $mineSet = [HashSet[int]]::new([int[]]$mine)
    $intersection = [HashSet[int]]::new($winsSet)
    $intersection.IntersectWith($mineSet)
    $count = $intersection.Count
    for($i = 0; $i -lt $count; $i++) {
        $nr = $i + $ri + 1
        if ($nr -lt $rows.Count) {
            $cardCount[$nr] = $cardCount[$nr] + $cardCount[$ri];
        }
    } 
    $ri++
}

$sum = $cardCount | Measure-Object -sum | Select-Object -ExpandProperty Sum
Write-Host $sum