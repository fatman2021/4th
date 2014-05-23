10 REM PRINT TAB(33);"HURKLE"
20 REM PRINT TAB(15);"CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
30 PRINT:PRINT:PRINT
110 N=5
120 G=10
210 PRINT
220 PRINT "A HURKLE IS HIDING ON A ";G;" BY ";G;" GRID. HOMEBASE"
230 PRINT "ON THE GRID IS POINT 0,0 IN THE SOUTHWEST CORNER,"
235 PRINT "AND ANY POINT ON THE GRID IS DESIGNATED BY A"
240 PRINT "PAIR OF WHOLE NUMBERS SEPERATED BY A COMMA. THE FIRST"
245 PRINT "NUMBER IS THE HORIZONTAL POSITION AND THE SECOND NUMBER"
246 PRINT "IS THE VERTICAL POSITION. YOU MUST TRY TO"
250 PRINT "GUESS THE HURKLE'S GRIDPOINT. YOU GET ";N;" TRIES."
260 PRINT "AFTER EACH TRY, I WILL TELL YOU THE APPROXIMATE"
270 PRINT "DIRECTION TO GO TO LOOK FOR THE HURKLE."
280 PRINT
285 A=RND(G)
286 B=RND(G)
310 FOR K=1 TO N
320 PRINT "GUESS #";K
330 INPUT "X (we): ";X : INPUT "Y (ns): "; Y : P=X-A : IF P<0 THEN P=-P
335 Q=Y-B : IF Q<0 THEN Q=-Q
340 IF P+Q=0 THEN GOTO 500
350 REM PRINT INFO
360 GOSUB 610
370 PRINT
380 NEXT K
410 PRINT
420 PRINT "SORRY, THAT'S ";N;" GUESSES."
430 PRINT "THE HURKLE IS AT ";A;",";B
440 PRINT
450 PRINT "LET'S PLAY AGAIN, HURKLE IS HIDING."
460 PRINT
470 GOTO 285
500 REM
510 PRINT
520 PRINT "YOU FOUND HIM IN ";K;" GUESSES!"
540 GOTO 440
610 PRINT "GO ";
620 IF Y=B THEN GOTO 670
630 IF Y<B THEN GOTO 660
640 PRINT "SOUTH";
650 GOTO 670
660 PRINT "NORTH";
670 IF X=A THEN GOTO 720
680 IF X<A THEN GOTO 710
690 PRINT "WEST";
700 GOTO 720
710 PRINT "EAST";
720 PRINT
730 RETURN
999 END