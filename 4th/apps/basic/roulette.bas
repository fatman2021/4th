1 PRINT "RUSSIAN ROULETTE"
2 PRINT "CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
3 PRINT:PRINT:PRINT
5 PRINT "THIS IS A GAME OF >>>>>>>>>>RUSSIAN ROULETTE."
10 PRINT:PRINT "HERE IS A REVOLVER."
20 PRINT "TYPE '1' TO SPIN CHAMBER AND PULL TRIGGER."
22 PRINT "TYPE '2' TO GIVE UP."
23 PRINT "GO";
25 N=0
30 INPUT I
31 IF I#2 THEN GOTO 35
32 PRINT "     CHICKEN!!!!!"
33 END
35 N=N+1
40 IF RND(100)>83 THEN GOTO 70
45 IF N>10 THEN GOTO 80
50 PRINT "- CLICK -"
60 PRINT: GOTO 30
70 PRINT "     BANG!!!!!   YOU'RE DEAD!"
71 PRINT "CONDOLENCES WILL BE SENT TO YOUR RELATIVES."
72 PRINT:PRINT:PRINT
75 PRINT "...NEXT VICTIM...":GOTO 20
80 PRINT "YOU WIN!!!!!"
85 PRINT "LET SOMEONE ELSE BLOW HIS BRAINS OUT."
90 GOTO 10
99 END
