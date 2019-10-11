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
* check3 - performed an open() and a read() so that had to mean a file, and "sesame" was one of the parameters pushed on the stack so that must be the filename. There was a buffer that was memset and the size was 10 bytes so that must be the size of the required string. There was a branch of checks that looked to be for each letter (in their ascii ordinal value) which spelled out " they burn"
