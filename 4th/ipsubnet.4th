\ ipsubnet.4th

\ Calculate Subnet for IP Address and Mask

\ Copyright (c) 1999 Marty McGowan
\ Provided under the terms of the GNU General Public License

\ Required source files:
\     none
\ Revisions:

\	1999-12-30 created       MJM
\       2007-10-27 ported to 4tH JLB
\       2008-01-09 lib change    JLB
\       2012-10-28 3.62.0 change JLB

\ this program computes the full IP Subnet, given an IP address
\ and the subnet mask expressed as either a dotted quad, or the
\ now more popular /#bits form.
\ i wrote it in response to a 468 K-byte (!!) Windows program
\ which does the same thing.
\ user instructions are below, and printed once gratuitously or
\ at user request:  .help

\    -- Marty McGowan  
\          mcgowan@alum.mit.edu 	- home
\ 		 mcfly@workmail.com	- work

[needs lib/interprt.4th]

: dashes
	." ===================================================" cr
;
: separator	cr dashes cr ;
: .HELP	cr
	." Usage Examples (enter addresses without dots)" 	
	separator
	."     10   4   1 2 DOTTED.QUAD IP-ADDR " cr	
	."    255 255 192 0 DOTTED.QUAD MASK"     cr
	."  or:" cr
        ."    18 #BITS MASK"             cr
	."  and then:"     cr
	."    SUBNET?"   cr
	."  prints your answer "  cr
	." After both IP-ADDR and MASK are set," cr
	." either may be changed for a new SUBNET? query." cr
	." to repeat this message: .HELP"
        separator
;
: riteByte		dup 255 and swap 8 rshift ;
: print.quad	riteByte riteByte riteByte riteByte drop . . . . ;
: dotted.quad	>r >r >r 256 * r> + 256 * r> + 256 * r> + ;
: #bits		negate 32 + 1 swap lshift 1- invert ;

 variable _ip   1 constant _ipset
 variable _mask 2 constant _maskset
 variable _set  1 2 + constant MUSTSET
 
: toset	_set @  or  _set ! ;
: isset?	_set @ MUSTSET = ;
: ip-addr	_ip !     _ipset toset ;
: mask	_mask ! _maskset toset ;

: subnet?	isset? if _ip @ _mask @
		dup			." MASK:     " print.quad cr
		2dup and 1+		." GATEWAY:  " print.quad cr
		invert dup 1+     ." NET SIZE: " . cr
		       or         ." UPPER:    " print.quad cr
		else separator ." Please follow instructions:" cr .help 
		then
;

\  -------------
\  4tH interface
\  -------------

: bye quit ;

create wordlist
  ," print.quad"  ' print.quad ,
  ," dotted.quad" ' dotted.quad ,
  ," #bits"       ' #bits ,
  ," ip-addr"     ' ip-addr ,
  ," mask"        ' mask ,
  ," subnet?"     ' subnet? ,
  ," .help"       ' .help ,
  ," bye"         ' bye ,
  ," exit"        ' bye ,
  null ,

wordlist to dictionary
:noname ." Unknown command '" type ." '" cr ; is NotFound

: ipsubnet
  .help
  begin
    ." OK" cr
    refill drop ['] interpret
    catch if ." Error" cr then
  again
;

ipsubnet