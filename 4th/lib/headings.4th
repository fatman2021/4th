\ 4tH library - Compass headings - Copyright 2012 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

[UNDEFINED] point>row [IF]
[UNDEFINED] row       [IF] include row.4th [THEN]
24 string (compass)                    \ protect search string against
                                       \ overwriting in PAD
create (heading)                       \ name and maximum heading
  ," North"                562 ,
  ," North by east"       1687 ,
  ," North-northeast"     2812 ,
  ," Northeast by north"  3937 ,
  ," Northeast"           5062 ,
  ," Northeast by east"   6187 ,
  ," East-northeast"      7312 ,
  ," East by north"       8437 ,
  ," East"                9562 ,
  ," East by south"      10687 ,
  ," East-southeast"     11812 ,
  ," Southeast by east"  12937 ,
  ," Southeast"          14062 ,
  ," Southeast by south" 15187 ,
  ," South-southeast"    16312 ,
  ," South by east"      17437 ,
  ," South"              18562 ,
  ," South by west"      19687 ,
  ," South-southwest"    20812 ,
  ," Southwest by south" 21937 ,
  ," Southwest"          23062 ,
  ," Southwest by west"  24187 ,
  ," West-southwest"     25312 ,
  ," West by south"      26437 ,
  ," West"               27562 ,
  ," West by north"      28687 ,
  ," West-northwest"     29812 ,
  ," Northwest by west"  30937 ,
  ," Northwest"          32062 ,
  ," Northwest by north" 33187 ,
  ," North-northwest"    34312 ,
  ," North by west"      35437 ,
  ," North"              36562 ,
  NULL ,
                                       \ set range between 0' and 360'
: >0<360 36000 >r r@ mod r@ + r> mod ; ( n1 -- n2)
: row>compass @c count ;               ( v -- a n)
: row>point (heading) - 2 cells / 32 mod 1+ ;
: row>heading cell+ @c >0<360 562 over over - >0<360 dup rot - >0<360 ;
: point>row 1- 2* cells (heading) + ;  ( n -- v)

: compass>row                          ( a n -- v f)
  (compass) place (compass) count      \ save compass string
  (heading) 2 string-key row 0= 2nip   \ search table, discard string
;                                      \ return address and flag

: heading>row                          ( n -- v)
  >0<360 (heading) 1 cells +           \ normalize, shift one field in table
  begin over over @c > while cell+ cell+ repeat nip cell-
;                                      \ convert to row

[DEFINED] 4TH# [IF]
  hide (heading)
  hide (compass)
[THEN]
[THEN]

