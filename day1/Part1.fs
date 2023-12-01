module Part1

open System.IO
open System

let getNumber s =
    let digits = s |> Seq.filter Char.IsDigit 
    let firstDigit = digits |> Seq.head
    let lastDigit = digits |> Seq.rev |> Seq.head
    int <| $"{firstDigit}{lastDigit}"
    

let lines = File.ReadAllLines("input.txt")
let r = lines |> Seq.map getNumber |> Seq.sum

printf "%A" r
