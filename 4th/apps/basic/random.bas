10 REM DISPLAY 64 RANDOM NUMBERS < 100 ON 8 LINES
20 LET I=0
30 LET A=RND(100) : PRINT A,
40 LET I=I+1
50 IF I/8*8=I THEN PRINT
60 IF I<64 THEN GOTO 30
70 END
