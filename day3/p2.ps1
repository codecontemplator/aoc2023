$rowsRaw = Get-Content "data.txt" | % { "." + $_ + "." }

$ri = 0;
$emptyRow = New-Object String @('.', $rowsRaw[0].Length)
$rows =  @($emptyRow) + $rowsRaw + @($emptyRow)
$sum = 0
$nums = @{}

foreach($row in $rows)
{
    $results = $row | Select-String "\d+" -AllMatches
    foreach($m in $results.Matches) 
    {
        $index = $m.Index
        $len = $m.Length
        $value = $m.Value

        $s1 = $rows[$ri-1].Substring($index-1, $len+2) | Select-String "\*"
        $s2 = $rows[$ri].Substring($index-1, $len+2) | Select-String "\*"
        $s3 = $rows[$ri+1].Substring($index-1, $len+2) | Select-String "\*"
        if ($s1.Matches.Success) {
            $nums["($($ri-1),$($s1.Matches.Index + $index))"] += @([int]$value)
        }        
        if ($s2.Matches.Success) {
            $nums["($($ri),$($s2.Matches.Index + $index))"] += @([int]$value)
        }        
        if ($s3.Matches.Success) {
            $nums["($($ri+1),$($s3.Matches.Index + $index))"] += @([int]$value)
        }        
    }
    $ri++;
}

$sum = 0
foreach($k in $nums.Keys)
{
    $vs = $nums[$k]
    if ($vs.Count -eq 2)
    {
        $sum += $vs[0] * $vs[1]
    }
}

Write-Host $sum
