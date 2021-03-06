\ 4tH library - FERF ZEN - Copyright 2009,2011 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

[UNDEFINED] ferf [IF]
[UNDEFINED] >taylor [IF] include lib/zentaylr.4th [THEN]

create (a)
  705230784 ,
  422820123 ,
   92705272 ,
    1520143 ,
    2765672 ,
     430638 ,
does> swap cells + @c -10 ;

: ferf
  2dup fabs 1378 -3 f<
  if
    2dup >taylor
            3 -taylor
           10 +taylor
           42 -taylor
          216 +taylor
         1320 -taylor
         9360 +taylor
        75600 -taylor
       685440 +taylor
      6894720 -taylor
     76204800 +taylor
    918086400 -taylor
    2drop 2drop
    112837916 -8 f*
  else
    over 0> >r fabs 2dup 1 s>f
    6 0 do 2over i (a) f* f+ 2rot 2rot 2over f* 2rot loop
    2dup f* 2dup f* 2dup f* 2dup f* 1 s>f 2swap f/ -1 s>f f+
    2swap 2drop 2swap 2drop r> if fnegate then
  then
;

[DEFINED] 4TH# [IF]
  hide (a)
[THEN]
[THEN]

\ : ferf-test
\  -2 s>f begin
\    2dup 2 s>f F<
\  while
\    2dup 2dup f. ferf f. cr
\    5 -2 f+
\  repeat 2drop depth .
\ ; ferf-test
