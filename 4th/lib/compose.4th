\ 4tH library - COMPOSE - Copyright 2013 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

\ Assemble executable sequences of execution tokens at runtime

[UNDEFINED] compose      [IF]
[UNDEFINED] /composition [IF]
  255 constant /composition            \ size of xt array
[THEN]

[DEFINED] 4TH# [IF]
/composition array (composition)       \ storage of xt sequences
[ELSE]
create (composition) /composition cells allot
(composition) value (opus)             \ ANS Forth compatibility
[THEN]
                                       \ initialize/reset compose buffer
: overture (composition) to (opus) ;   ( --)
                                       \ compose a sequence of xt's
: compose                              ( xt1 xt2 xtn n -- x)
  dup begin dup while rot >r 1- repeat \ use return stack to reverse order
  drop 1+ >r (opus) r@ cells over + over
  begin over over > while r> over ! cell+ repeat drop to (opus)
;                                      \ execute a sequence of xt's
                                       ( x --)
: recite dup @ cells bounds cell+ ?do i @ execute 1 cells +loop ;

[DEFINED] 4TH# [IF]
  hide (composition)
  hide (opus)
[THEN]
[THEN]
