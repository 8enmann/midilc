let string_of_list l = 
  let rec help_string_of_list l s = match l
  with [] -> s ^ "]"
  | head :: tail -> help_string_of_list tail (s ^ (string_of_int head) ^ ";") in
  help_string_of_list l "["

let replace_element l i n = 
  let a = Array.of_list l in
  a.(i+3) <- n; Array.to_list a;;

print_endline (string_of_list (replace_element [3;4;5;6;7;8] 2 1))
  
