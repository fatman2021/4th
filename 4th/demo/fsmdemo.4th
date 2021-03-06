\ ---------------------------------------------------
\     (c) Copyright 2001  Julian V. Noble.
\         Permission is granted by the author to
\         use this software for any application pro-
\         vided this copyright notice is preserved.
\ ---------------------------------------------------

include lib/fsm.4th
include lib/row.4th

:token (drop) drop ;
:token (emit) emit ;
:token >0 0 ;
:token >1 1 ;
:token >2 2 ;

0 enum 'other' enum 'digit' enum 'sign' constant 'point'
                                       \  Classifier for example below
create categorize
  char 0 , 'digit' ,
  char 1 , 'digit' ,
  char 2 , 'digit' ,
  char 3 , 'digit' ,
  char 4 , 'digit' ,
  char 5 , 'digit' ,
  char 6 , 'digit' ,
  char 7 , 'digit' ,
  char 8 , 'digit' ,
  char 9 , 'digit' ,
  char + , 'sign'  ,
  char - , 'sign'  ,
  char . , 'point' ,
  char , , 'point' ,
  NULL ,                               ( char -- category )
does> 2 num-key row if cell+ @c else drop 'other' then nip ;

\ And this is actual code: who needs more documentation!
\ 3 rows, 4 columns times two plus the FSM header

3 4 * 2 * fsm.head + array fixed.pt
                                       \  Example FSM, illustrating usage
4 wide fixed.pt fsm                    ( n n' -- )
\ input   other    ||  digit    ||  - sign   ||  decimal point
\ state  ----------------------------------------------------------
  ( 0 )  (DROP) >0 || (EMIT) >1 || (EMIT) >1 || (EMIT) >2 ||
  ( 1 )  (DROP) >1 || (EMIT) >1 || (DROP) >1 || (EMIT) >2 ||
  ( 2 )  (DROP) >2 || (EMIT) >2 || (DROP) >2 || (DROP) >2 ||

: Getafix  fixed.pt to fsm.current 0 fsm.state !
           ." Enter an FP number: " refill drop 0 parse
\           s" dsff-345.dsds4467dffs"
           BEGIN DUP WHILE
           OVER C@ DUP categorize fsm.run chop REPEAT 2DROP CR ;

Getafix
