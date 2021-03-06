\ 4tH deskcalculator - (c) 1997,2009 HanSoft & Partners
[needs lib/interprt.4th]

\ In this section the exceptions are defined
\ and several routines that handle them

1 constant #UndefName
2 constant #BadVariable

8 constant #variables
#variables array variables

: variable?                            \ is it a valid variable?
  dup #variables 1- invert and         ( n f)
  if #BadVariable throw else cells variables + then
;

\ Here all internal commands are listed
\ and placed inside the dictionary.
\ Checking is done by the routines above.
\ Note: there are aliases!

: +_      + ;                          \ + command
: -_      - ;                          \ - command
: *_      * ;                          \ * command
: /_      / ;                          \ / command
: ._      . ;                          \ . command
: .r_     .r ;                         \ .r command
: drop_   drop ;                       \ drop command
: dup_    dup ;                        \ dup command
: rot_    rot ;                        \ rot command
: /mod_   /mod ;                       \ /mod command
: */_     */ ;                         \ */ command
: */mod_  */mod ;                      \ */mod command
: swap_   swap ;                       \ swap command
: over_   over ;                       \ over command
: !_      variable? ! ;                \ ! command
: +!_     variable? +! ;               \ +! command
: @_      variable? @ ;                \ @ command
: ?_      variable? ? ;                \ ? command
: mod_    mod ;                        \ mod command
: abs_    abs ;                        \ abs command
: negate_ negate ;                     \ negate command
: invert_ invert ;                     \ invert command
: min_    min ;                        \ min command
: max_    max ;                        \ max command
: or_     or ;                         \ or command
: xor_    xor ;                        \ xor command
: and_    and ;                        \ and command
: lshift_ lshift ;                     \ lshift command
: rshift_ rshift ;                     \ rshift command
: inc     1+ ;                         \ inc command
: dec     1- ;                         \ dec command
: 2*_     2* ;                         \ 2* command
: 2/_     2/ ;                         \ 2/ command
: spaces_ spaces ;                     \ spaces command
: emit_   emit ;                       \ emit command
: base!   36 min 2 max base ! ;        \ base command
: decimal_ decimal ;                   \ decimal command
: hex_  hex ;                          \ hex command
: octal_ octal ;                       \ octal command
: binary 2 base! ;                     \ binary command
: depth_ depth ;                       \ depth command
: bye quit ;                           \ quit command
: dummy ;                              \ dummy command
: space_ space ;                       \ space command
: cr_ cr ;                             \ cr command
: A. 0 ;                               \ variable A
: B. 1 ;                               \ variable B
: C. 2 ;                               \ variable C
: D. 3 ;                               \ variable D
: E. 4 ;                               \ variable E
: F. 5 ;                               \ variable F
: G. 6 ;                               \ variable G
: H. 7 ;                               \ variable H
: .(_ 41 parse type ;                  \ .( command
: (_ 41 parse drop drop ;              \ ( command
: char_ bl parse drop c@ ;             \ char command
: time_ time ;                         \ time command

create wordlist                        \ dictionary
  ," +"       ' +_       ,
  ," th"      ' +_       ,
  ," -"       ' -_       ,
  ," *"       ' *_       ,
  ," /"       ' /_       ,
  ," quit"    ' bye      ,
  ," bye"     ' bye      ,
  ," q"       ' bye      ,
  ," ."       ' ._       ,
  ," .r"      ' .r_      ,
  ," drop"    ' drop_    ,
  ," dup"     ' dup_     ,
  ," rot"     ' rot_     ,
  ," swap"    ' swap_    ,
  ," over"    ' over_    ,
  ," A."      ' A.       ,
  ," B."      ' B.       ,
  ," C."      ' C.       ,
  ," D."      ' D.       ,
  ," E."      ' E.       ,
  ," F."      ' F.       ,
  ," G."      ' G.       ,
  ," H."      ' H.       ,
  ," !"       ' !_       ,
  ," +!"      ' +!_      ,
  ," @"       ' @_       ,
  ," ?"       ' ?_       ,
  ," base!"   ' base!    ,
  ," decimal" ' decimal_ ,
  ," octal"   ' octal_   ,
  ," hex"     ' hex_     ,
  ," binary"  ' binary   ,
  ," .("      ' .(_      ,
  ," mod"     ' mod_     ,
  ," abs"     ' abs_     ,
  ," negate"  ' negate_  ,
  ," invert"  ' invert_  ,
  ," min"     ' min_     ,
  ," max"     ' max_     ,
  ," or"      ' or_      ,
  ," and"     ' and_     ,
  ," xor"     ' xor_     ,
  ," lshift"  ' lshift_  ,
  ," rshift"  ' rshift_  ,
  ," depth"   ' depth_   ,
  ," cells"   ' dummy    ,
  ," 1+"      ' inc      ,
  ," cell+"   ' inc      ,
  ," 1-"      ' dec      ,
  ," cell-"   ' dec      ,
  ," space"   ' space_   ,
  ," spaces"  ' spaces_  ,
  ," 2*"      ' 2*_      ,
  ," 2/"      ' 2/_      ,
  ," emit"    ' emit_    ,
  ," char"    ' char_    ,
  ," [char]"  ' char_    ,
  ," time"    ' time_    ,
  ," ("       ' (_       ,
  ," /mod"    ' /mod_    ,
  ," */"      ' */_      ,
  ," */mod"   ' */mod_   ,
  ," cr"      ' cr_      ,
  NULL ,
  
\ Set up the interpreter loop
 wordlist to dictionary                \ assign dictionary
:noname #UndefName throw ; is NotFound \ standard 'abort' word

\ This is the actual DC program. It features only a
\ message handler and a interpretation-loop.
\ The rest is handled by library routines.

create Message
  ," Exception ignored"
  ," Undefined name"
  ," Bad variable"

: ShowMessage                          ( n --)
  0 max Message swap th @c count type space 
;                                      \ print error message

: dc
  begin
    ." OK" cr refill drop 
    ['] interpret catch dup
    if ShowMessage else drop then
  again
;

dc
