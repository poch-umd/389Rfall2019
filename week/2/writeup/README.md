# Writeup 2 - OSINT

Name: Marco Roxas
Section: 101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas

## Assignment Writeup

### Part 1 (45 pts)

1.
ejnorman84's real name looks to be Eric J. Norman

By doing a web search for ejnorman84 a paste on pastebin was discovered at https://pastebin.com/4yJRgkFm (abbreviated contents shown):

    .:L3AKED CR3DZ:.
    ...
    Eric J. Norman...
    ...
    ejnorman84:p********a
    ejnoman:@****************1
    EricNorman84:h*****


2.
ejnorman84 works for Watt's Amp, with a url of http://wattsamp.net

(This was found on their twitter page)

3.
Social media accounts

A twitter page was found via a search on https://usersearch.org and searching for EricNorman84:

Twitter: https://twitter.com/EricNorman84

Email accounts (Published on twitter page, the first one was also from whois via cli)

ejnorman84@gmail.com  
ejnorman@protonmail.com  

(these addresses were verified using verify-email.org as well)

Address & phone number (from whois via cli information)

Eric Norman  
1300 Adabel Dr  
El Paso TX 79835  
Phone: +1.2026562837

4.
IP addresses

    wattsamp.net  157.230.179.99

This information was discovered using the dig cli tool.

5.
Hidden files or directories found on website:

    robots.txt

6.
Ports open on the website

* 22 - the ssh port but it only allows public key authentication
* 80 - the web server port
* 1337 - labeled waste but can be logged into using nc or telnet (or a script)

7.
The web server discloses the server as Ubuntu server as part of a file not found error message:

Apache/2.4.29 (Ubuntu) Server at wattsamp.net Port 80

8.
Easter eggs found so far:

In robots.txt  
    *CMSC389R-{n0_indexing_pls}

From https://securitytrails.com/list/ip/157.230.179.99  
    *CMSC389R-{Do_you-N0T_See_this}

From the web page by viewing the source (main page)
    *CMSC389R-{html_h@x0r_lulz}


### Part 2 (75 pts)

*Please use this space to detail your approach and solutions for part 2. Don't forget to upload your completed source code to this /writeup directory as well!*
