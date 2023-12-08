cd $PSScriptRoot
$rows = Get-Content "data.txt"
$steps = $rows[0]
$dictRaw = $rows | Select-Object -Skip 2

$dict = @{}
$dictRaw | % {
    $r = $_
    if (-not($r -match "^(\w\w\w)\s+=\s+\((\w\w\w), (\w\w\w)\)$")) {
        throw "bad"
    }
    $src = $Matches[1]
    $left = $Matches[2]
    $right = $Matches[3]
    $dict[$src] = [pscustomobject]@{
        left  = $left
        right = $right
    }
}

$curNode = "AAA"
$stepCount = 0
$i = 0
while ($curNode -ne "ZZZ") {
    $step = $steps[$i]
    $alt = $dict[$curNode]
    if ($step -eq "L") {
        $curNode = $alt.left    
    } else {
        $curNode = $alt.right    
    }
    $i++
    if ($i -ge $steps.Length) {
        $i = 0
    }
    $stepCount++
    if ($stepCount % $steps.Length -eq 0) {
        write-host "."
    }
}

write-host "Steps: $stepCount"
