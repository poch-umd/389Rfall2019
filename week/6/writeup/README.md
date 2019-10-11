# Writeup 6 - Binaries I

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas

## Assignment Writeup

### Part 1 (50 pts)

`Flag found: CMSC389R-{di5a55_0r_d13}`

### Part 2 (50 pts)

The final input consisted of the following:
* "Oh God" (in quote or double-quote marks) as a command-line parameter
* FOOBAR=" my eyes" as an exported environment variable
* " they burn" as a 10-byte text file named sesame

The checks looked to be implemented as follows:
* check1 - seemed to read a string from somewhere and did a strcmp() with the string "Oh God".  I just guessed that it was probably reading from the command line
* check2 - called setenv() and there were two strings "FOOBAR" and "seye ym " so initially it looked like it was just checking if FOOBAR contained that string. But check2 was doing some processing in the comparison, so a sensible guess was that it was probably comparing the reverse, so that's what I set FOOBAR to
* check3 - performed an open() and a read() so that had to mean a file, and "sesame" was one of the parameters pushed on the stack so that must be the filename. There was a buffer that was memset and the size was 11 bytes (10 plus another for the null) so that must be the size of the required string. There was a branch of checks that looked to be for each letter (in their ascii ordinal value) which spelled out " they burn"

At first I thought that it was a small enough program to just use objdump to trace and understand what it's doing but that turned out to be (almost) futile and I couldn't even tell what the strings were.

A commented attempt for check1 is shown:

~~~~
00001261 <check1>:
    1261:	55                   	push   %ebp
    1262:	89 e5                	mov    %esp,%ebp
    1264:	53                   	push   %ebx
    1265:	83 ec 14             	sub    $0x14,%esp       ; make room for 20 bytes

    1268:	e8 b3 fe ff ff       	call   1120 <__x86.get_pc_thunk.bx>

    126d:	81 c3 93 2d 00 00    	add    $0x2d93,%ebx
    1273:	83 ec 08             	sub    $0x8,%esp        ; make room for 8 more bytes
    1276:	8d 83 08 e0 ff ff    	lea    -0x1ff8(%ebx),%eax ; obtaining one of the pointers

    127c:	50                   	push   %eax             ; pushes two parameters, which are pointers
    127d:	ff 75 0c             	pushl  0xc(%ebp)        ; a parameter to check1 (is a pointer const char *)

    1280:	e8 bb fd ff ff       	call   1040 <strcmp@plt>
    1285:	83 c4 10             	add    $0x10,%esp       ; 16 bytes

    1288:	85 c0                	test   %eax,%eax
    128a:	74 07                	je     1293 <check1+0x32> ; if the two strings are equal, continue; otherwise return

    128c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1291:	eb 44                	jmp    12d7 <check1+0x76>

    1293:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)    ; moving 0 to a local variable
    129a:	eb 21                	jmp    12bd <check1+0x5c> ; there is a loop here

    129c:	83 ec 0c             	sub    $0xc,%esp
    129f:	6a 00                	push   $0x0               ; pushes five parameters on stack (so update flag has 5 params)

    12a1:	ff 75 f4             	pushl  -0xc(%ebp)         ; one parameter is the counter
    12a4:	8d 83 3c 00 00 00    	lea    0x3c(%ebx),%eax
    12aa:	50                   	push   %eax               ; another is related to the strcmp parameter
    12ab:	ff 75 0c             	pushl  0xc(%ebp)          ; another is a parameter to check1
    12ae:	ff 75 08             	pushl  0x8(%ebp)          ; another is a parameter to check1
    12b1:	e8 67 ff ff ff       	call   121d <update_flag>
    12b6:	83 c4 20             	add    $0x20,%esp         ; these are the parameters, 32 bytes total
    12b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)    ; increments loop variable

    12bd:	83 ec 0c             	sub    $0xc,%esp
    12c0:	ff 75 0c             	pushl  0xc(%ebp)
    12c3:	e8 d8 fd ff ff       	call   10a0 <strlen@plt>
    12c8:	83 c4 10             	add    $0x10,%esp
    12cb:	8b 55 f4             	mov    -0xc(%ebp),%edx    ; compare index with length of string
    12ce:	39 d0                	cmp    %edx,%eax
    12d0:	77 ca                	ja     129c <check1+0x3b> ; loop if index is higher than length of string
    12d2:	b8 00 00 00 00       	mov    $0x0,%eax

    12d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12da:	c9                   	leave  
    12db:	c3                   	ret    
~~~~

So binaryninja was opened on the file and it just became possible to see the structure of each check in a graphical manner (there are if/else branches, switch branches, and loop arrows). In addition variable names are added in.

The routines check1-3 were examined to see what checks they were doing in order to pass them. The update_flag routine was only a single block.

The advice on the assignment page was spot on, it was just more efficient to understand the structure rather than the boilerplate code.
