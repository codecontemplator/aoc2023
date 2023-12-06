cd $PSScriptRoot
$rows = Get-Content ".\data.txt"
$rows[0] -match "seeds: (.*)"
$seedsRanges = $Matches[1] -split "\s+" | % { [int64]$_ }
$seeds = @()
for($i = 0; $i -lt $seedsRanges.Length; $i += 2) {
    $start = $seedsRanges[$i]
    $len = $seedsRanges[$i+1]
    for($j=0; $j -lt $len; $j++) {
        $seeds += @($start + $j)
    }
}

$restRows = $rows | Select-Object -Skip 1 | ? { $_ -notmatch "map"}
$maps = $restRows | % { $sc = 0} { 
    if ($_ -match "^\s*$") {
        $sc++ | Out-Null
    } else {
        [int64]$dest, [int64]$src, [int64]$cnt = $_ -split "\s+"
        [pscustomobject]@{
            count=$sc
            range=[PSCustomObject]@{
                dest = $dest
                src =  $src
                cnt = $cnt
            }
        }    
    }
} | Group-Object -Property "count" | Select-Object Group

$result = @()
foreach($seed in $seeds) {
    $x = $seed
    foreach($map in $maps) 
    {
        # test each range
        foreach($rangeTmp in $map.Group)
        {
            $range = $rangeTmp.range
            $lb = $x -ge $range.src
            $ub = $x -lt ($range.src+$range.cnt)
            if ($lb -and $ub) 
            {
                $i = $x - $range.src
                $x = $i + $range.dest
                break
            }
        }
    }
    $result += $x
}

$result | measure -Minimum
