\ 4tH CSV to LyX converter - Copyright 2007,2013 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

include lib/argopen.4th
include lib/parsing.4th
include lib/csvfrom.4th

10240 constant /buffer
/buffer buffer: buffer

s| <column alignment="center" valignment="top" leftline="true" width="0">| sconstant <column>
s| <column alignment="center" valignment="top" leftline="true" rightline="true" width="0">| sconstant </column>

s| <row topline="true">| sconstant <row>
s| <row topline="true" bottomline="true">| sconstant </row>

s| <cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">| sconstant <cell>
s| <cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">| sconstant </cell>

: .# 0 .r ;                            ( n --)

: Preprocess                           ( sv sh d -- sv sh d)
  buffer /buffer source!
  ." #4tH 3.60 created this file. For more info see http://www.xs4all.nl/~thebeez/4tH" cr
  ." \lyxformat 221" cr                \ other possible versions are:
  ." \textclass article" cr            \ 210, 215, 216, 217, 218, 220
  ." \begin_preamble" cr               \ may be dropped (KLyX)
  ." \usepackage{latexsym}" cr         \ may be dropped (KLyX)
  ." \end_preamble" cr                 \ may be dropped (KLyX)
  ." \language dutch" cr               \ 'english' is ok too ;-)
  ." \inputencoding auto" cr
  ." \fontscheme pslatex" cr
  ." \graphics default" cr
  ." \paperfontsize default" cr
  ." \spacing single " cr
  ." \papersize a4paper" cr
  ." \paperpackage a4" cr
  ." \use_geometry 0" cr
  ." \use_amsmath 0" cr
  ." \use_natbib 0" cr                 \ 221 only
  ." \use_numerical_citations 0" cr    \ 221 only
  ." \paperorientation portrait" cr
  ." \secnumdepth 3" cr
  ." \tocdepth 3" cr
  ." \paragraph_separation indent" cr  \ 'skip' is ok too
  ." \defskip medskip" cr
  ." \quotes_language english" cr
  ." \quotes_times 2" cr
  ." \papercolumns 1" cr
  ." \papersides 1" cr
  ." \paperpagestyle default" cr cr
  ." \layout Standard" cr cr cr
  ." \begin_inset  Tabular" cr
  .| <lyxtabular version="3" rows="| rot dup .#
  .| " columns="| rot dup .# .| ">| cr
  ." <features>" cr
  dup 1- 0 ?do <column> type cr loop </column> type cr rot
;

: .cell                                ( d a n -- d)
  type cr ." \begin_inset Text" cr cr ." \layout Standard" cr cr
  dup parse-csv csv> type cr ." \end_inset" cr ." </cell>" cr
;

: ReadLine refill buffer count nip /buffer 1- = abort" Line too long" ;
: WriteCells over 1- 0 ?do <cell> .cell loop </cell> .cell ;
: .row type cr ReadLine 0= abort" Cannot read CSV" WriteCells ." </row>" cr ;
: WriteRows >r over r> swap 1- 0 ?do <row> .row loop </row> .row ;
: Vertical 0 begin ReadLine while 1+ repeat ;
: rewind-csv over rewind abort" Cannot rewind CSV" ;

: Horizontal                           ( d -- d n)
  ReadLine 0= abort" Read error"
  0 begin over parse-csv? while 2drop 1+ repeat 2drop
;

: PostProcess                          ( --)
  ." </lyxtabular>" cr cr
  ." \end_inset" cr cr 
  ." \the_end" cr
;

: OpenFiles                            ( -- h1 h2)
  argn 4 < abort" Usage: csv2lyx ascii csv-file lyx-file"
  input 2 arg-open output 3 arg-open
;

: GetParms                             ( h1 h2 -- h1 h2 sv sh d)
  1 args number                        ( h1 h2)
  Horizontal swap >r >r rewind-csv     ( h1 h2)
  Vertical >r rewind-csv               ( h1 h2)
  r> r> r> 
;

: Convert
  OpenFiles GetParms                   \ open files and get file information
  Preprocess WriteRows PostProcess     \ process the CSV file
  drop drop drop close close           \ clean stack and close files
;

Convert 