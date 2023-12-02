open System.IO

type Color = Red | Green | Blue

type Reveal = {
    count : int
    color : Color
}

type Game = {
    id : int
    reveals : List<List<Reveal>>
}

let parseColor (s : string) : Color =
    match s with
    | "red" -> Red
    | "blue" -> Blue
    | "green" -> Green
    | _ -> raise(new System.Exception(s))

let parseReveal (s : string) : Reveal =
    let [|countStr; colorStr|] = s.Trim().Split(' ')
    { count = int countStr; color = parseColor colorStr }

let parseReveals (s : string) = 
    let colors = s.Split(",");
    Seq.map parseReveal colors |> Seq.toList

let parseGame (s : string) =
    let [|game; rest|] = s.Split(":")
    let reveals = rest.Split(";") |> Seq.toList
    let gameId = game.Split(" ").[1] |> int
    { id = gameId; reveals = List.map parseReveals reveals }


let isPossibleRev (r : int) (g : int) (b : int)  (rev : Reveal) : bool =
    match rev.color with
    | Red -> rev.count <= r
    | Green -> rev.count <= g
    | Blue -> rev.count <= b

let isPossibleGame (r : int) (g : int) (b : int) (game : Game) : bool =
    Seq.forall (isPossibleRev r g b) (Seq.concat game.reveals)

let r = File.ReadAllLines "input.txt" |> Array.map parseGame |> Array.filter (isPossibleGame 12 13 14) |> Array.map (_.id) |> Seq.sum

printf "%A" r

