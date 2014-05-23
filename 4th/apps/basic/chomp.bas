10 REM TAB(33);"CHOMP"
20 REM TAB(15);"CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
30 PRINT:PRINT:PRINT
40 REM DIM A(10,10)
100 REM *** THE GAME OF CHOMP *** COPYRIGHT PCC 1973 ***
110 PRINT
120 PRINT "THIS IS THE GAME OF CHOMP (SCIENTIFIC AMERICAN, JAN 1973)"
130 INPUT "DO YOU WANT THE RULES (1=YES, 0=NO!): "; R
150 IF R=0 THEN GOTO 340
170 R=5
180 C=7
190 PRINT "CHOMP IS FOR 1 OR MORE PLAYERS (HUMANS ONLY)."
200 PRINT
210 PRINT "HERE'S HOW A BOARD LOOKS (THIS ONE IS 5 BY 7):"
220 GOSUB 1100
230 PRINT
240 PRINT "THE BOARD IS A BIG COOKIE - R ROWS HIGH AND C COLUMNS"
250 PRINT "WIDE. YOU INPUT R AND C AT THE START. IN THE UPPER LEFT"
260 PRINT "CORNER OF THE COOKIE IS A POISON SQUARE (P). THE ONE WHO"
270 PRINT "CHOMPS THE POISON SQUARE LOSES. TO TAKE A CHOMP, TYPE THE"
280 PRINT "ROW AND COLUMN OF ONE OF THE SQUARES ON THE COOKIE."
290 PRINT "ALL OF THE SQUARES BELOW AND TO THE RIGHT OF THAT SQUARE"
300 PRINT "(INCLUDING THAT SQUARE, TOO) DISAPPEAR -- CHOMP!!"
310 PRINT "NO FAIR CHOMPING SQUARES THAT HAVE ALREADY BEEN CHOMPED,"
320 PRINT "OR THAT ARE OUTSIDE THE ORIGINAL DIMENSIONS OF THE COOKIE."
330 PRINT 
340 PRINT "HERE WE GO..."
370 FOR I=0 TO 9
372 FOR J=0 TO 9
375 @(I*10+J)=0
377 NEXT J
379 NEXT I
380 PRINT 
390 INPUT "HOW MANY PLAYERS: "; P
410 A=0
420 INPUT "HOW MANY ROWS: "; R
440 IF R < 10 THEN GOTO 470
450 PRINT "TOO MANY ROWS (9 IS MAXIMUM). NOW, ";
460 GOTO 420
470 INPUT "HOW MANY COLUMNS: "; C
490 IF C < 10 THEN GOTO 530
500 PRINT "TOO MANY COLUMNS (9 IS MAXIMUM). NOW, ";
510 GOTO 470
530 PRINT 
540 GOSUB 1100
770 REM GET CHOMPS FOR EACH PLAYER IN TURN
780 LET A=A+1
790 LET X=A%P
800 IF X=0 THEN X=P
820 PRINT "PLAYER ";X
830 PRINT "COORDINATES OF CHOMP (ROW,COLUMN)"
840 INPUT Y : INPUT Z
850 IF Y<1 THEN GOTO 920
860 IF Y>R THEN GOTO 920
870 IF Z<1 THEN GOTO 920
880 IF Z>C THEN GOTO 920
890 IF @((Y-1)*10+(Z-1))=0 THEN GOTO 920
900 IF @((Y-1)*10+(Z-1))=-1 THEN GOTO 1010
910 GOTO 940
920 PRINT "NO FAIR. YOU'RE TRYING TO CHOMP ON EMPTY SPACE!"
930 GOTO 820
940 FOR I=Y-1 TO R-1
950 FOR J=Z-1 TO C-1
960 @(I*10+J)=0
970 NEXT J
980 NEXT I
990 GOSUB 1160 : GOTO 770
1000 REM END OF GAME DETECTED IN LINE 900
1010 PRINT "YOU LOSE, PLAYER ";X
1020 PRINT 
1030 INPUT "AGAIN (1=YES, 0=NO!): "; R
1050 IF R=1 THEN GOTO 340
1060 END
1100 FOR I=0 TO R-1
1110 FOR J=0 TO C-1
1120 @(I*10+J)=1
1130 NEXT J
1140 NEXT I
1150 @(0)=-1
1160 REM PRINT THE BOARD
1170 PRINT
1180 PRINT "       1 2 3 4 5 6 7 8 9"
1190 FOR I=0 TO R-1
1200 PRINT I+1;"      ";
1210 FOR J=0 TO C-1
1220 IF @(I*10+J)=-1 THEN PRINT "P ";
1230 IF @(I*10+J)=1 THEN PRINT "* ";
1240 NEXT J
1250 PRINT
1260 NEXT I
1270 PRINT 
1280 RETURN
