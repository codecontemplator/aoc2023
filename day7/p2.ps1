function Classify([string]$hand) {
    $x = $hand.ToCharArray() | 
        Group-Object | 
        Sort-Object -Property Count -Descending |
        Select-Object -ExpandProperty Count
    if ($x[0] -eq 5) {
        return 7
    } elseif ($x[0] -eq 4) {
        return 6
    } elseif (($x[0] -eq 3) -and ($x[1] -eq 2)) {
        return 5
    } elseif ($x[0] -eq 3) {
        return 4
    } elseif (($x[0] -eq 2) -and ($x[1] -eq 2)) {
        return 3
    } elseif ($x[0] -eq 2) {
        return 2
    } else {
        return 1
    }
}

function Classify2([string]$hand) {
    if ($hand.Contains("J")) {
        $classes = "23456789TJQKA".ToCharArray() | % { Classify $hand.Replace("J",$_) } 
        $max = $classes | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
        return [int]$max
    } else {
        return Classify $hand
    }
}

function RateCard([string]$hand) {
    $hand.ToCharArray() |
    % { "J23456789TQKA".IndexOf($_) }
}

cd $PSScriptRoot
Get-Content "data.txt" | % {
    $x, [int]$y = $_.Split(" ")
    [pscustomobject]@{
        hand = $x
        score = $y
        class = Classify2 $x
        rate = RateCard $x
    }
} | 
Sort-Object {$_.class},{$_.rate[0]},{$_.rate[1]},{$_.rate[2]},{$_.rate[3]},{$_.rate[4]} |
% { $i = 1; [int64]$r = 0 } { $r += $_.score * $i; $i++ } { $r }

