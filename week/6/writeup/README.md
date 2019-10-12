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

When disassembled and shown in graphical form in binaryninja, the check routines looked to have the same pattern in common of reading from some input and then performing an assembler cmp.  Those cmp's and their corresponding conditional jumps represented if/else branches in the original source. Then there was a recurring return value of 0xffffffff (-1 in signed decimal) indicating failure.

In addition there always was a block of assembler that called into the update_flag routine upon success.

The difference between the check routines were in their structure - check3 utilized a multi-way branch via a switch whereas check1 and check2 had if/else logic. These differences indicated the nature of each check routine.

The flag looks to be computed somehow. I took a look at the routine in binaryninja and it was a block of assembler code, so the flag wasn't stored in the traditional sense. The routine also had five parameters.

To comment on the process, at first I thought that it was a small enough program to just use objdump to trace and understand what's going on but that turned out to be futile and I couldn't even tell what the strings were. Using binaryninja was a sort of revelation in figuring out how the program worked.  I'd like to note also that the advice on the assignment page was spot on, it was just more efficient to understand the structure rather than the boilerplate code.
