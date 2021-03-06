\ 4tH library - DEBUG - Copyright 2005,2009 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

[undefined] ~~ [if]                    \ the only public word!
[needs lib/rdepth.4th]                 \ all other words should be private
[needs lib/anstools.4th]
[needs lib/interprt.4th]
[needs lib/dump.4th]
                                       \ some simple helpers
variable stack'                        \ original stack height
variable /source'                      \ original source length
variable source'                       \ original source address
variable base'                         \ original BASE value
variable >in'                          \ original >IN value
variable cin'                          \ original CIN value
variable cout'                         \ original COUT value

 16 constant min-dump                  \ minimum dump length
128 constant max-dump                  \ maximum dump length

/tib string tib'                       \ new tib
/pad string pad'                       \ new pad
                                       \ some helper words
: >spad pad pad' /pad cmove ; : spad> pad' pad /pad cmove ;
: args? depth stack' @ - swap > dup 0= if ." Stack empty " then ;
: 2? 2 args? ; : 1? 1 args? ; : chomp vars max last min ;
: crop tuck hi swap - min tib max swap spad> ; 
: dump' min-dump max max-dump min crop dump ;

\ Here all internal commands are listed
\ and placed inside the dictionary.
\ Checking is done by the routines above.

: ._       1? if . then ;              \ . command
: emit_    1? if emit then ;           \ emit command
: @_       1? if chomp @ then ;        \ @ command
: abs_     1? if abs then ;            \ abs command
: negate_  1? if negate then ;         \ negate command
: invert_  1? if invert then ;         \ invert command
: count_   1? if 1 crop drop count then ;
: dup_     1? if dup then ;            \ count and dup commands
: drop_    1? if drop then ;           \ drop command
: swap_    2? if swap then ;           \ swap command
: over_    2? if over then ;           \ over command   
: or_      2? if or then ;             \ or command
: xor_     2? if xor then ;            \ xor command
: and_     2? if and then ;            \ and command
: lshift_  2? if lshift then ;         \ lshift command
: rshift_  2? if rshift then ;         \ rshift command
: +_       2? if + then ;              \ + command
: -_       2? if - then ;              \ - command
: *_       2? if * then ;              \ * command
: type_    2? if crop type then ;      \ type command
: dump_    2? if dump' then ;          \ dump command
: ?_       @_ ._ ;                     \ ? command
: decimal_ decimal ;                   \ decimal command
: hex_     hex ;                       \ hex command
: octal_   octal ;                     \ octal command
: binary   2 base ! ;                  \ binary command
: depth_   depth ;                     \ depth command
: rdepth_  rdepth 3 - ;                \ rdepth command
: r.s_     r> r> r> r.s >r >r >r ;     \ r.s command
: source_  source' @ /source' @ ;      \ source command
: tib_     tib ;                       \ TIB address
: /tib_    /tib ;                      \ TIB size
: pad_     pad ;                       \ PAD address
: /pad_    /pad ;                      \ PAD size
: base_    base' ;                     \ BASE address
: >in_     >in' ;                      \ >IN address
: out_     out ;                       \ OUT address
: spad     pad' ;                      \ shadow PAD address
: clear    depth stack' @ ?do drop loop ;
: bye      r> r> drop drop ;           \ clear and bye commands

create wordlist                        \ dictionary
  ," ."       ' ._       ,
  ," emit"    ' emit_    ,
  ," @"       ' @_       ,
  ," abs"     ' abs_     ,
  ," negate"  ' negate_  ,
  ," invert"  ' invert_  ,
  ," count"   ' count_   ,
  ," dup"     ' dup_     ,
  ," drop"    ' drop_    ,
  ," swap"    ' swap_    ,
  ," over"    ' over_    ,
  ," or"      ' or_      ,
  ," and"     ' and_     ,
  ," xor"     ' xor_     ,
  ," lshift"  ' lshift_  ,
  ," rshift"  ' rshift_  ,
  ," +"       ' +_       ,
  ," -"       ' -_       ,
  ," *"       ' *_       ,
  ," type"    ' type_    ,
  ," dump"    ' dump_    ,
  ," ?"       ' ?_       ,
  ," decimal" ' decimal_ ,
  ," octal"   ' octal_   ,
  ," hex"     ' hex_     ,
  ," binary"  ' binary   ,
  ," depth"   ' depth_   ,
  ," rdepth"  ' rdepth_  ,
  ," r.s"     ' r.s_     ,
  ," .s"      ' .s       ,
  ," source"  ' source_  ,
  ," tib"     ' tib_     ,
  ," /tib"    ' /tib_    ,
  ," pad"     ' pad_     ,
  ," /pad"    ' /pad_    ,
  ," base"    ' base_    ,
  ," >in"     ' >in_     ,
  ," out"     ' out_     ,
  ," spad"    ' spad     ,
  ," clear"   ' clear    ,
  ," bye"     ' bye      ,
  NULL ,

wordlist to dictionary                 \ we cannot use THROW/CATCH
                                       \ because it uses stackframes!
: debug begin ." OK" cr refill drop interpret again ;

: ~~                                   \ breakpoint routine
  >spad depth stack' !                 \ page PAD out and save stack size
  base @ base' ! >in @ >in' !          \ save BASE and >IN
  source /source' ! source' !          \ save SOURCE
  tib' /tib source!                    \ set new SOURCE
  cin cin' ! cout cout' !              \ save channels
  stdin use stdout use                 \ use keyboard and screen
  debug                                \ now start the debugger
  cin' @ use cout' @ use               \ use original channels again
  source_ source!                      \ restore SOURCE
  base' @ base ! >in' @ >in !          \ restore BASE and >IN
  clear spad>                          \ clear the stack and page PAD in
;

[defined] 4th# [if]
hide wordlist                          \ internal dictionary
hide debug                             \ debug interpreter
hide stack'                            \ original stack height
hide /source'                          \ original source length
hide source'                           \ orginal source address
hide tib'                              \ new tib
hide >in'                              \ original >IN value
hide cin'                              \ original CIN value
hide cout'                             \ original COUT value
hide base'                             \ original BASE value
hide min-dump                          \ minimal dump length
hide max-dump                          \ maximum dump length
hide >spad                             \ paging PAD out
hide spad>                             \ paging PAD in
hide args?                             \ check # of arguments
hide 1?                                \ check if 1 argument
hide 2?                                \ check if 2 arguments 
hide crop                              \ adjust Char Segment address
hide chomp                             \ adjust Int Segment address
hide dump'                             \ wrapper for dump
hide ._                                \ . command
hide emit_                             \ emit command
hide @_                                \ @ command
hide abs_                              \ abs command
hide negate_                           \ negate command
hide invert_                           \ invert command
hide count_                            \ count command
hide dup_                              \ dup command
hide drop_                             \ drop command
hide swap_                             \ swap command
hide over_                             \ over command
hide or_                               \ or command
hide xor_                              \ xor command
hide and_                              \ and command
hide lshift_                           \ lshift command
hide rshift_                           \ rshift command
hide +_                                \ + command
hide -_                                \ - command
hide *_                                \ * command
hide type_                             \ type command
hide dump_                             \ dump command
hide ?_                                \ ? command
hide decimal_                          \ decimal command
hide hex_                              \ hex command
hide octal_                            \ octal command
hide binary                            \ binary command
hide depth_                            \ depth command
hide rdepth_                           \ rdepth command
hide r.s_                              \ r.s command
hide source_                           \ source command
hide tib_                              \ TIB address
hide /tib_                             \ TIB size
hide pad_                              \ PAD address
hide /pad_                             \ PAD size
hide base_                             \ BASE address
hide >in_                              \ >IN address
hide out_                              \ OUT address
hide spad                              \ shadow PAD address
hide clear                             \ clear command
hide bye                               \ bye command
[then]
[then]
