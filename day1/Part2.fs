module Part2

open System.Text.RegularExpressions
open System.IO
open System
open System.Diagnostics

let tokenToDigit token =
    match token with 
    | "one" -> "1"
    | "two" -> "2"
    | "three" -> "3"
    | "four" -> "4"
    | "five" -> "5"
    | "six" -> "6"
    | "seven" -> "7"
    | "eight" -> "8"
    | "nine" -> "9"
    | _ -> 
        Debug.Assert(token.Length = 1)
        Debug.Assert(Char.IsDigit(token[0]))
        token

let revString x = new string(x |> Seq.rev |> Seq.toArray)

let getNumber s =

    let digits = ["one";"two";"three";"four";"five";"six";"seven";"eight";"nine"];
    let digitsRev = digits |> List.map revString

    let regExFirst = "\d|" + String.Join('|',digits)
    let firstDigit = Regex.Match(s, regExFirst).Value |> tokenToDigit
    let regExLast = "\d|" + String.Join('|',digitsRev)
    let lastDigit = Regex.Match(revString s, regExLast).Value |> revString |> tokenToDigit

    int <| $"{firstDigit}{lastDigit}"

let lines = File.ReadAllLines("input.txt")
let r = lines |> Array.map getNumber |> Seq.sum

printf "part2: %A" r