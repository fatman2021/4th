\ spiles.forth --------------------------------
\ "No Weighting" from Starting Forth Chapter 12

include lib/interprt.4th

0 VALUE density
0 VALUE tan(theta)

16 string id

1 constant oops                 \ general error

: MATERIAL ( 'string density tan[theta] -- )
    id place
    to tan(theta) 
    to density
;

: .SUBSTANCE	id COUNT TYPE ;

: FOOT	10 * ; ( feet -- scaled-height )
: INCH	100 12 */  5 +  10 /  + ; ( scaled-height -- scaled-height' )
: /TAN	1000 tan(theta) */ ; ( n -- n' )  

: PILE  ( scaled-height -- )
	DUP DUP 10 */  1000 */  355 339 */  /TAN /TAN
	density 200 */ . ." tons of "  .SUBSTANCE cr ;

: cement 131 700 s" cement" material ;
: loose-gravel 93 649 s" loose gravel" material ;
: packed-gravel 100 700 s" packed gravel" material ;  
: dry-sand 90 754 s" dry sand" material ;
: wet-sand 118 900 s" wet sand" material ;
: clay 120 727 s" clay" material ;
: bye quit ;
                                      
\ table of materials
create wordlist
  ," cement"        ' cement , 
  ," loose-gravel"  ' loose-gravel ,
  ," packed-gravel" ' packed-gravel ,
  ," dry-sand"      ' dry-sand ,
  ," wet-sand"      ' wet-sand ,
  ," clay"          ' clay ,
  ," foot"          ' foot ,
  ," pile"          ' pile ,
  ," inch"          ' inch ,
  ," bye"           ' bye ,
  NULL ,

wordlist to dictionary
:noname oops throw ; is NotFound       ( --)

: calculator
  begin
    ." OK" cr refill drop ['] interpret catch if ." Oops! " then
  again
;

calculator