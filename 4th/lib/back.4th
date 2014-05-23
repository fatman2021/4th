\ 4tH library - TOOLBELT BACK - Copyright 2003,2012 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

[UNDEFINED] TRIM     [IF]
[UNDEFINED] IS-TYPE  [IF] [NEEDS lib/tokenize.4th] [THEN]
1 string (delimiter)                   \ string for delimiter

: (is-delimiter) (delimiter) c@ = ;   ( str len char -- str len-i )
: back (delimiter) c! ['] (is-delimiter) is is-type scan< ;
: -scan over >r back r> over - over >r >r chars + r> r> if -1 /string then ;

[DEFINED] 4TH# [IF]
  hide (delimiter)
  hide (is-delimiter)
[THEN]
[THEN]

