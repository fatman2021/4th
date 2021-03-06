\ 4tH library - REPLACE - Copyright 2004 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

[UNDEFINED] search [IF]
[needs lib/search.4th]
[THEN]

[UNDEFINED] replaceall [IF]
\ Delete string a2/n2 from string a1/n1
\ Return the resulting string in a1/n3 and the remainder of the
\ line after the delete in string a2/n4
\ If the deletion was made, f is 1 otherwise 0

: delete                        ( a1 n1 a2 n2 -- a1 n3 a2 n4 f)
  2>r 2dup 2r> dup >r search 
  dup r> swap >r >r             ( a1 n1 a2 n2 f) 
  if                            ( a1 n1 a2 n2) 
    2swap r@ - 2swap r@ -       ( a1 n3 a2 n4) 
    2dup over r@ chars +        ( a1 n3 a2 n4 a3) 
    -rot cmove                  ( a1 n3 a2 n4) 
  then
  r> drop r>
;

\ Delete all occurences of string a2/n2 in string a1/n1
\ Return the resulting string in a1/n3

: deleteall                     ( a1 n1 a2 n2 -- a1 n3)
  2>r swap dup rot              ( a1 a1 n1)
  begin                         ( a1 a1 n1)
    2r> 2dup 2>r delete         ( a1 a1 n3 a2 n4 f)
  while                         ( a1 a1 n3 a2 n4)
    2swap 2drop                 ( a1 a2 n4)
  repeat                        ( a1 a2 n4)
  2drop chars + over -          ( a1 n5)
  2r> 2drop                     ( a1 n5)
;  

\ Spread string a1/n1 at position n2 by n3 characters
\ Return the resulting string in a1/n4 and the opened up
\ space in string a2 n3

: spread                        ( a1 n1 n2 n3 -- a1 n4 a2 n3)
  rot >r >r                     ( a1 n2)
  over over chars + swap        ( a1 a2 n2)
  over dup r@ + rot             ( a1 a2 a2 a3 n2)
  r> swap r@ swap - swap >r     ( a1 a2 a2 a3 n1-n2)
  cmove r@ rot r> r> +          ( a2 n3 a1 n4)
  2swap                         ( a1 n4 a2 n3)
;

\ Insert string a2/n2 into string a1/n1 at position n3
\ Return the resulting string in a1/n3 and the remainder of
\ the line after the insertion in a3/n4

: insert                        ( a1 n1 a2 n2 n3 -- a1 n3 a3 n4)
  -rot 2dup 2>r                 ( a1 n1 n3 a2 n2)
  nip spread                    ( a1 n3 a3 n2)
  over 2r>                      ( a1 n3 a3 n2 a3 a2 n2)
  rot swap cmove chars +        ( a1 n3 a4)
  >r 2dup chars + r@ -          ( a1 n3 n4)
  r> swap
;

\ Replace string a2/n2 in string a1/n1 by string a3/n3
\ Return the resulting string in a1/n4 and the remainder of the
\ line after the delete in string a4/n5
\ If the replacement was made, f is 1 otherwise 0

: replace                       ( a1 n1 a2 n2 a3 n3 -- a1 n4 a4 n5 f)
  2>r delete dup 2r> rot >r 2>r
  if
    nip over swap - 2r> rot insert
  else
    2r> 2drop
  then
  r>
;

\ Replace all occurences of string a2/n2 in string a1/n1 by string a3/n3
\ Return the resulting string in a1/n4

: replaceall                    ( a1 n1 a2 n2 a3 n3 -- a1 n4)
  2>r 2>r swap dup rot
  begin 
    2r> 2dup 2r> 2dup 2>r 2swap 2>r replace 
  while
    2swap 2drop
  repeat
  2drop chars + over -
  2r> 2r> 2drop 2drop
;  
[THEN]

