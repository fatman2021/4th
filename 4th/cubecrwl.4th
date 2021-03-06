\ 4tH Cube Crawler - Copyright 2010 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

include lib/gmskiss.4th
include lib/istype.4th
include lib/interprt.4th

\ The cubecrawler starts at point A and randomly chooses
\ a direction when he comes at one of the other corners.
\ When he returns to A, he dies.

\ This implementation uses a state of the art randomizer,
\ the so-called "SuperKiss".

\    h-----g
\   /|    /|
\ e/----f/ |
\ |  d--|--c
\ | /   | /
\ a/----b/

     3 constant #direction             \ the number of possible directions
char A constant start                  \ starting point
 start value    end                    \ finishing point
     0 value    oldest                 \ holds age of oldest cubecrawler
       defer    action                 \ vectors the required action
                                       \ maps the points to all corners
offset cube
  char B c, char D c, char E c,        \ point A
  char A c, char C c, char F c,        \ point B
  char B c, char D c, char G c,        \ point C
  char A c, char C c, char H c,        \ point D
  char A c, char F c, char H c,        \ point E
  char B c, char E c, char G c,        \ point F
  char C c, char F c, char H c,        \ point G
  char D c, char E c, char G c,        \ point H
                                       \ internal words
: direction? start - #direction * kiss abs #direction mod + cube ;
: older? over over > if ." The oldest crawler is " over . ." .." cr then ;
: die oldest older? over max to oldest + ;
: crawl ." Crawling from " dup emit direction? ."  to " dup emit ." .." cr ;
: life begin action dup end <> while swap 1+ swap repeat drop ;
: 1000lives 1000 0 do 1 start life die loop ." Another 1000 generations.." cr ;
: apocalypse swap / 1000 /mod ." Average age: " 0 .r [char] . emit . cr ;
: dynasty 0 over over do 1000lives loop apocalypse ;
: crawler 1 start life ." Dead after " . ." moves." cr ;
                                       \ external words
: live ['] crawl is action crawler ;   \ live a single life
: dynasties ['] direction? is action 0 to oldest dynasty ;
: _quit quit ;                         \ live an entire dynasty (1000 lives)
: _+ + ;                               \ addition
: _- - ;                               \ subtraction
: _* * ;                               \ multiplication
: _/ / ;                               \ division
: _. . ;                               \ print TOS
                                       \ show the cubecrawler cube
: .cube                                ( --)
  ."    h-----g" cr
  ."   /|    /|" cr
  ." e/----f/ |" cr
  ." |  d--|--c" cr
  ." | /   | /"  cr
  ." a/----b/"   cr cr
;
                                       \ show help
: help                                 ( --)
  ." live         -- live a single cubecrawler life" cr
  ." n dynasties  -- live n thousands of lives" cr
  ." endpoint c   -- set the endpoint to corner c" cr
  ." +, -, /, *   -- perform simple integer calculations" cr
  ." p, .         -- print Top of Stack (destructive)" cr
  ." cube         -- show the cubecrawler cube" cr
  ." help         -- show this screen" cr
  ." quit         -- exit cubecrawler" cr cr 
;
                                       \ sets the endpoint
: endpoint                             ( --)
  bl parse-word                        \ get the next word
  if c@ bl invert and dup is-upper if [char] H min to end exit then then drop
;                                      \ determine whether it is a valid point
                                       \ interpreter symbol table
create wordlist                        \ maps commands to execution semantics
  ," +"          ' _+ ,
  ," -"          ' _- ,
  ," *"          ' _* ,
  ," /"          ' _/ ,
  ," p"          ' _. ,
  ," ."          ' _. ,  
  ," exit"       ' _quit ,
  ," quit"       ' _quit ,
  ," bye"        ' _quit ,
  ," help"       ' help ,
  ," cube"       ' .cube ,
  ," live"       ' live ,
  ," endpoint"   ' endpoint ,
  ," dynasties"  ' dynasties ,
  NULL ,
  
wordlist to dictionary                 \ assign wordlist to dictionary
                                       \ The interpreter itself
: cubecrawler                          ( --)
  ." Initializing.." cr randomize      \ initialize SuperKiss randomizer
  ." Type 'help' for help." cr         \ show help message
  begin                                \ show the prompt and get a command
    ." OK" cr refill drop              \ interpret and issue oops when needed
    ['] interpret catch if ." Oops " then
  again                                \ repeat command loop eternally
;

cubecrawler
