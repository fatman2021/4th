\ Constants optimizer - Copyright 2007,2011 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

\ Typical use:
\   4th cdq myprogram.4th | 4th cxq optconst.4th

include lib/leading.4th
include lib/row.4th

0 enum literal enum operator constant other

create operator?
  ," literal" literal ,
  ," negate"  operator ,
  ," *"       operator , 
  ," +"       operator ,
  ," -"       operator ,
  ," /"       operator ,
  null ,
does> 2 string-key row if nip nip cell+ @c else drop 2drop other then ;

: none 0 dup other ;                   ( -- line count command)
: ?line if ." Optimize LITERAL sequence at word " . cr else drop then ; 
: word> bl parse-word operator? ;      ( -- n)
: line> [char] ] parse chop -leading number ;
: validate over (error) <> over literal = and ;
: valid >r >r literal = if 1+ r> drop r> else drop drop r> 1 r> then ;
: invalid nip operator = rot 1- 0> rot literal = and and ?line none ;
: valid? line> word> validate if valid else invalid then ;
: literals none begin refill while valid? repeat drop drop drop ;

literals
