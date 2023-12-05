using namespace System.Collections.Generic

cd $PSScriptRoot
$rows = Get-Content "data.txt"
[int64]$sum = 0
foreach($row in $rows)
{
    $row -match "^Card\s+(\d+):(.*?)\|(.*)$" | Out-Null
    $wins = $Matches[2].Trim() -split "\s+" | % { [int]$_ }
    $mine = $Matches[3].Trim() -split "\s+" | % { [int]$_ }
    $winsSet = [HashSet[int]]::new([int[]]$wins)
    $mineSet = [HashSet[int]]::new([int[]]$mine)
    $intersection = [HashSet[int]]::new($winsSet)
    $intersection.IntersectWith($mineSet)
    $count = $intersection.Count 
    if ($count -gt 0)
    {
        $sum += [Math]::Pow(2, $count-1)
    }
}

Write-Host $sum