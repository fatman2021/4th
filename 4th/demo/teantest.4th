include lib/tean.4th
include lib/anstools.4th
include lib/ansdbl.4th
include lib/pickroll.4th

32 #tean!   \ set the default values

\ Tests

variable #errors
variable k#
variable j#

: tttean
   17 0 do i j# !
      81 16 do 
         2dup
         i #tean!
         +tean
         2rot over 4 pick xor +
         tuck 3 pick + xor swap 2rot 2rot
         j k# @ or 7 and 0= if  cr .s  then
         -tean
         2over d= not if ." FAIL" 1 #errors +!  then
      16 +loop
      i k# @ or 7 and 0= if  cr i . j# ?  then
      2 pick + swap 3 pick xor swap
   loop
;

: ttteans
   0 #errors !
   base @ >r  hex
   MyKey 4 bounds do 0 i ! loop
   0 0 0 0
   17 0 do i k# !
      tttean
      2over MyKey +! MyKey cell+ +!
      2over MyKey @ + MyKey 2 cells + +! MyKey cell+ @ + MyKey 3 cells + +!
   loop 2drop 2drop
   r> base !
   cr  #errors @ if  ." Failed with "  #errors @ .  ."  errors!!! "
      else  ." Passed "  then
;

\ Known good output of ttteans

ttteans

0 [IF]
[6] 3AE4E7F3h 1072425Fh 0h 0h 1072425Fh 2A72A594h
[6] -784F086Eh -2195C477h 0h 0h -8ECE127h -21162B28h
[6] -137F7C36h 665F8E58h 0h 0h 45A55Dh 4D0E600h
[6] -1A3D3632h CAFFCF2h 0h 0h 4AD0ED50h -36DB2EEh
[6] B0D30F9h 10DE56C3h 0h 0h -1E136FE1h -220E5D8Ch
0 0
[6] -7E440F0Ah -30ACDFA1h A1CCCD5h -331AB38Dh 774B231Dh -2AFAA0DDh
[6] -2625E3B9h 4F37FF68h A1CCCD5h -331AB38Dh -1A0D001h 929ED49h
[6] -602E1678h -32A92150h A1CCCD5h -331AB38Dh -583B3CF1h 78B5171Fh
[6] 660F43B1h -3D7FFA7Bh A1CCCD5h -331AB38Dh 6AF8CF5Dh 375EA4B4h
[6] -3B71662Dh -1B04DB78h A1CCCD5h -331AB38Dh 44745CB2h -42794A26h
8 0
[6] 41949923h -56BE49F7h 7C3240BAh -412DA6B6h 1506ADDDh 67DCF5BCh
[6] -3333B979h -B56EAD3h 7C3240BAh -412DA6B6h AF3C607h -67503589h
[6] 49910221h 2C4422E3h 7C3240BAh -412DA6B6h -4A8B4CFh 591921C3h10000
[6] -413D8DE1h 7E24524Fh 7C3240BAh -412DA6B6h 18712D4Dh 792F1DEFh
[6] 6D78E85Eh 69B62A9Fh 7C3240BAh -412DA6B6h 5553AA4Fh 6A046FA2h
10 0
[6] -70517341h 655C4D5Eh -3486E1E0h -6FFDD857h 236C3274h -23061BA1h
[6] -73030AD4h -1E3E42D0h -3486E1E0h -6FFDD857h -C341C93h 2190BC63h
[6] 40043002h D4C0656h -3486E1E0h -6FFDD857h -588943F6h -40534128h
[6] 473FCBB3h 440451B2h -3486E1E0h -6FFDD857h 76BC7B5Eh -3CC85601h
[6] 77B5D704h -317BD22Eh -3486E1E0h -6FFDD857h -32BFE86Dh 6205EEE5h
0 8
[6] 6CDF4CEBh -55983F8Ch -3DF29F7Ah -5F02850Fh -2FB165B6h -471A52FFh
[6] 67B91B10h 22AD4EE0h -3DF29F7Ah -5F02850Fh 149AC287h -1746F6E5h
[6] -BAE4051h 29095F8Ch -3DF29F7Ah -5F02850Fh 61E50BBCh 6ADF4533h
[6] -1840873Ah -7E55CE1Fh -3DF29F7Ah -5F02850Fh -530E9206h -6DBB6A78h
[6] -309790E3h -3AD5ABBh -3DF29F7Ah -5F02850Fh -62E8F45Eh 2C847296h
8 8
[6] 3F6866E6h -62225F57h -7CCC9F40h -570384FAh 66F258B6h -7D06B3D2h
[6] -26D6D1ADh 303765E2h -7CCC9F40h -570384FAh -52CE5C21h -49F61D2Dh
[6] -39C968DBh -7D34C3CEh -7CCC9F40h -570384FAh -744507FDh -63AB82BCh
[6] 385DA9A9h -4468BF9Ah -7CCC9F40h -570384FAh -1056CEFh 42D3FE26h
[6] 29A9F3F5h 631CCEB6h -7CCC9F40h -570384FAh -6027D807h -5128745Ah
10 8
[6] -7A75911Eh 55A02C8Dh 4A040C21h 52CB2790h 5ED72126h -38F3F434h
[6] 6ABEF3BBh -1E9957B0h 4A040C21h 52CB2790h E4C1521h DCDF509h
[6] 1B5C29CAh -2D17EBBAh 4A040C21h 52CB2790h -64C067B3h -610539D5h
[6] -3577C78Bh -2A4824B4h 4A040C21h 52CB2790h 1993EECCh -3E3C98Dh
[6] 3FD5EDA3h -25622B7Eh 4A040C21h 52CB2790h -31923EBDh 1AC00154h
0 10
[6] -21392671h -3285EA49h 553872A7h -5D691E21h F22FD15h -D9AE43Fh
[6] -1789EF9Bh 4F10E7F4h 553872A7h -5D691E21h 5F500BB2h -18601E0Ah
[6] 2EBB7013h -5B605D69h 553872A7h -5D691E21h -4207553Ah 222DBDDFh
[6] 1D9B5773h -4BC7A133h 553872A7h -5D691E21h 2123CC25h 7EE7C893h
[6] 1440247Dh 50402BEAh 553872A7h -5D691E21h -7E636592h -4664B8DCh
8 10
[6] 5BB6EA16h 70E6E0D4h 5269AA55h 62C4141Ah -254C81C6h -542FC5EEh
[6] 37ECCF41h 21441540h 5269AA55h 62C4141Ah -14142186h 4B161017h
[6] 1DD59311h -48EB6747h 5269AA55h 62C4141Ah -5DC3B3C8h 7324C397h
[6] 58442D88h 6CA214h 5269AA55h 62C4141Ah 548D9A4Ah 45251C85h
[6] -3A047B9Eh -79DFC6B7h 5269AA55h 62C4141Ah -22084543h 179F70A1h
10 10
[THEN]