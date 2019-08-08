\ Copyright http://wiki.forthfreak.net/index.cgi?HigherOrderFunctions
\ Copyright 4tH version 2005, J.L. Bezemer
\ Demo HigherOrderFunctions

include lib/hiorder.4th

: _negate negate ;                     \ wrapper for negate
: _+ + ;                               \ wrapper for +

4 array data                           \ define an small array

4 0 do i dup 1+ data rot th ! loop     \ fill it with data

data 4 .cells                          \ 1 2 3 4
' _negate data 4 map                   \ negate all cells 
data 4 .cells                          \ -1 -2 -3 -4
0  ' _+ data 4 zip                     \ add all cells
.                                      \ -10
