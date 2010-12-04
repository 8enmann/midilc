module StringMap = Map.Make(String)

let note_map = StringMap.add "C" 0 StringMap.empty
let note_map = StringMap.add "R" (-1) note_map
let note_map = StringMap.add "D" 2 note_map
let note_map = StringMap.add "E" 4 note_map
let note_map = StringMap.add "F" 5 note_map
let note_map = StringMap.add "G" 7 note_map
let note_map = StringMap.add "A" 9 note_map
let note_map = StringMap.add "B" 11 note_map
let note_map = StringMap.add "w" 16 note_map
let note_map = StringMap.add "h" 8 note_map
let note_map = StringMap.add "q" 4 note_map
let note_map = StringMap.add "e" 2 note_map
let note_map = StringMap.add "s" 1 note_map



let int_of_note n =
  let a = Array.make 4 0 in
  a.(0) <- StringMap.find (String.sub n 0 1) note_map;
  for i = 1 to (String.length n) - 1 do
    (* check for an accidental *)
    if n.[i] == 'b' then a.(0) <- a.(0) - 1;
    if n.[i] == '#' then a.(0) <- a.(0) + 1;
    (* check for an octave *)
    if String.contains "0123456789" n.[i] then
      (a.(0) <- a.(0) + 12 * ((int_of_char n.[i])  - (int_of_char '0') + 1);
      a.(2) <- 1); (* mark octave as set *)
    (* check for a duration *)
    if String.contains "whqes" n.[i] then
      (a.(1) <- StringMap.find (String.sub n i 1) note_map;
      a.(3) <- 1) (* mark duration as set *)
  done;
  (* Set default octave *)
  if a.(2) == 0 then a.(0) <- a.(0) + 12 * 5;
  (* Set default duration *)
  if a.(3) == 0 then a.(1) <- 4;
  (*return*)
  (a.(0), a.(1))
  
  let temp = int_of_note "A4w" 
  let foo = print_string ((string_of_int (fst temp)) ^ " " ^ (string_of_int (snd temp)) ^ "\n")
  


