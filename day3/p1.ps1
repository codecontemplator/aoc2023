$rowsRaw = Get-Content "data.txt" | % { "." + $_ + "." }

$ri = 0;
$emptyRow = New-Object String @('.', $rowsRaw[0].Length)
$rows =  @($emptyRow) + $rowsRaw + @($emptyRow)
$sum = 0
foreach($row in $rows)
{
    $results = $row | Select-String "\d+" -AllMatches
    foreach($m in $results.Matches) 
    {
        $index = $m.Index
        $len = $m.Length
        $value = $m.Value

        $s1 = $rows[$ri-1].Substring($index-1, $len+2)
        $s2 = $rows[$ri].Substring($index-1, $len+2)
        $s3 = $rows[$ri+1].Substring($index-1, $len+2)
        $b1 = $s1 -match "^(\.|\d)*$"
        $b2 = $s2 -match "^(\.|\d)*$"
        $b3 = $s3  -match "^(\.|\d)*$"
        if (!$b1 -or !$b2 -or !$b3)
        {
            Write-Host $value
            $sum += [int]$value
        }
        
    }
    $ri++;
}

Write-Host $sum
