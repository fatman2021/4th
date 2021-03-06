\ 4tH "Guess your number" - Copyright 2012 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

\ Based on a silly game at http://www.quizyourprofile.com/guessyournumber.swf
\ A friend of my wondered how this worked, so I engineered this program
\ in order to illustrate the simplicity of the algorithm.

\ Amazing people still fall for these simple tricks!!

include lib/choose.4th                 \ for CHOOSE
include lib/enter.4th                  \ for ENTER

25 constant #number                    \ the number of numbers
 5 constant #color                     \ the number of colors
 8 constant scaler                     \ scaling factor for color

offset color-house                     \ the core of the trick:
   1 c, 12 c, 13 c,  4 c, 11 c,        \ a very simple matrix
  21 c,  9 c,  2 c, 10 c, 24 c,
  14 c, 25 c, 20 c, 17 c,  8 c,
  22 c, 23 c,  5 c,  3 c, 19 c,
   6 c, 16 c, 15 c, 18 c,  7 c,
                                       \ translating serials to strings
create colors                          ( n1 -- a n2)
  ," Purple"
  ," Green "
  ," Red   "
  ," Blue  "
  ," Black "
does> swap cells + @c count ;

#number array numbers                  \ temporary array to randomize
                                       \ the numbers when first displaying
: ?cr dup #color mod 0= if cr then ;   ( n -- n)
                                       \ get a number for the doors
: ?fake                                ( n --)
  if begin #number choose color-house over over = while drop repeat nip then
;                                      \ but NOT the one we supply
                                       \ setup the initial random matrix
: setup                                ( --)
  #number 0 do                         \ mash up the color-house matrix
    begin numbers #number choose th dup @ while drop repeat
    i color-house scaler * i #color mod + swap !
  loop                                 \ include the color as well
;
                                       \ show the randomized matrix
: .matrix                              ( --)
  #number 0 do                         \ unscramble number and color
    numbers i ?cr th @ scaler /mod 3 .r space colors type
  loop cr cr
;
                                       \ show some simple ASCII doors
: .doors                               ( --)
  ."  +-------+          +-------+          +-------+" cr
  ."  |  +-+  |          |  +-+  |          |  +-+  |" cr
  ."  |  | |  |          |  | |  |          |  | |  |" cr
  ."  |  +-+  |          |  +-+  |          |  +-+  |" cr
  ."  |o  1   |          |o  2   |          |o  3   |" cr
  ."  |  +-+  |          |  +-+  |          |  +-+  |" cr
  ."  |  | |  |          |  | |  |          |  | |  |" cr
  ."  |  +-+  |          |  +-+  |          |  +-+  |" cr
  ."  +-------+          +-------+          +-------+" cr
;

: .top
  ."  +-------+          +-------+          +-------+" cr
  ."  |      /|          |      /|          |      /|" cr
  ."  |     / |          |     / |          |     / |" cr
  ."  |    +  |          |    +  |          |    +  |" cr
;

: .bottom
  ."  |    |  |          |    |  |          |    |  |" cr
  ."  |    |o |          |    |o |          |    |o |" cr
  ."  |    |  |          |    |  |          |    |  |" cr
  ."  +----|  +          +----|  +          +----|  +" cr
  ."       | /                | /                | /" cr
  ."       |/                 |/                 |/" cr
;

: .middle                              ( n1 n2 -- n1 n2)
  4 1 do                               \ produce a fake number in the
    over over i <> ?fake               \ doors the user didn't choose
    ."  |"  3 .r  ."  |  |" i 3 =      \ draw the doors, place the number
    if cr else 9 spaces then           \ terminate line at door three
  loop
;
                                       \ invert the matrix and display
: .house                               ( --)
  ."    _   _   _   _   _"   cr        \ show the header
  ."   / \ / \ / \ / \ / \"  cr
  ."  | A | B | C | D | E |" cr
  ."  +---+---+---+---+---+" cr
  #color 0 do #color 0 do i #color * j + color-house 4 .r loop cr loop
  25 30 do i 4 .r -1 +loop cr cr       \ display color-house according
;                                      \ to the house
                                       \ let user select the color
: enter-color                          ( -- n)
  #color 0 do i 1+ . ." [" i colors -trailing type ." ]" 3 spaces loop cr
  begin                                \ get input and check
    enter dup #color > over 0> 0= or   \ if out of bounds
  while                                \ humbly excuse yourself
    drop ." Try again.." cr            \ and get another entry
  repeat 1- cr
;
                                       \ let user select the house
: enter-house                          ( -- n)
  .house                               \ display the houses
  begin                                \ let user select the house
    refill drop tib c@ bl or [char] a - dup 0< over #color 1- > or
  while                                \ if out of bounds
    drop ." Try again.." cr            \ humbly excuse yourself
  repeat cr                            \ and get another entry
;
                                       \ let user select the door
: enter-door                           ( -- n)
  begin enter dup 3 > over 0> 0= or while drop ." Try again.." cr repeat cr
;                                      \ if out of bounds get another entry
                                       \ perform the doors ceremony
: .revelation                          ( n1 n2 --)
  .top .middle .bottom cr              \ draw the doors
  ." So, did I put your number behind the correct door?" cr
  drop drop                            \ fake contents of other doors
;
                                       \ main program
: doors                                ( --)
  setup                                \ get color, house and door
  ." Choose one of these numbers:" cr .matrix
  ." Choose the color your number has:" cr cr enter-color
  ." Choose the house which has your number in it:" cr enter-house
  #color * + color-house              \ we got all required information!
  ." I will now put the number behind the door I think you will choose first."
  cr cr .doors cr ." Choose your favorite door: " enter-door .revelation
;                                      \ perform the doors ceremony

doors
