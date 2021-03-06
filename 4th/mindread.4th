\ Gedankenlesen

\ Prinzip:
\ Die Zahlen 9, 18, 27, 36, 45, 54, 63, 72, 81 
\ bekommen das gleiche Symbol zugeordnet. 
\ Alle uebrigen erhalten ein Symbol random zugeordnet, 
\ es muss nur druckbar sein.

include lib/choose.4th

\ choose a token, but no digit.
: token ( -- x )  126 58 - choose 58 + ;

variable symbol

: symbol!  ( -- )  token symbol ! ;

: sy. ( -- ) symbol @ emit ;

: symbol. ( I -- )
  DUP 9 MOD 0= SWAP 82 < AND
  IF sy. ELSE token emit THEN ;

: tabelle. ( -- )
  cr 100 0 DO
  I 2 .r space 
  I symbol. 2 spaces 
  I 1+ 10 /mod drop 0= IF cr THEN
  LOOP ;

: text.en ( --)
  cr ." MindReader in Forth"
  cr
  cr ." Think of a number with 2 digits (e.g. 54)"
  cr ." Subtract from this number its 2 digits "
     ." (54 -5 -4 = 45)"
  cr ." Find the symbol that corresponds "
     ." to this number"
  cr ." Concentrate on the symbol "
     ." and press enter..." ;

: ?again.en ( -- f )
  cr ." Again? --> press spacebar and enter! "
  refill drop tib c@ bl - 0= ;

\ english version
: MindReader  ( -- )
  BEGIN symbol!
  text.en cr tabelle. refill drop
  cr ." It is:  " sy. cr
  ?again.en 0= UNTIL ;

MindReader

\ fin  