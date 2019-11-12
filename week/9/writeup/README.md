# Writeup 9 - Forensics II

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas


## Assignment details

### Part 1 (45 Pts)

The pcap file was loaded in Wireshark and examined.

1. Warmup: what IP address has been attacked?

159.203.113.181

2. What kind of assessment tool(s) were the attackers using against the victim machine? List the name(s) of the tool(s) as well.

Looks like a file transfer and a port scanner: curl, nmap.

3. What are the hackers' IP addresses, and where are they connecting from?

142.93.136.81

The attackers look like are using a VM from Digital Ocean that is located in Amsterdam Holland. This was learned by looking it up on iplocation.net.

4. What port are they using to steal files on the server?

Port 21, the FTP port.

5. Which file did they steal? What kind of file is it? Do you recognize the file?

find_me.jpeg. It's a JPEG image file. By using Wireshark's export feature (there's probably a much easier way to do this) the packets can be saved as C arrays and a simple C program can be used to save the file.

6. Which file did the attackers leave behind on the server?

greetz.fpff

7. What is a countermeasure to prevent this kind of intrusion from happening again? Note: disabling the vulnerable service is *not* an option.

The attackers somehow knew a username and password to log on the FTP server and access the files. But besides that perhaps sensitive files can be placed where the FTP server cannot access them, and uploads can be disabled.

### Part 2 (55 Pts)

A parser was put together in Ruby (I'm more comfortable with Ruby than Python or Perl) which uses unpack to read off the items in the file (using ARGF allows the file to be either redirected or the filename placed in the command line).

1. When was `greetz.fpff` generated?

The timestamp was 2019-03-27T00:15:05-04:00 which is March 27, 2019 12:15 am (should be Eastern DST)

2. Who authored `greetz.fpff`?

fl1nch

4. List each section, giving us the data in it *and* its type.

There are 5 sections listed below with lengith and contents. The png file is saved is 3.png.

~~~~
1 ASCII 24: Hey you, keep looking :)
2 COORD 16: 52.336035, 4.880673
3 PNG 202776: saved in 3.png
4 ASCII 44: }R983CSMC_perg_tndid_u0y_yllufep0h{-R983CSMC
5 ASCII 80: Q01TQzM4OVIte2hleV9oM3lfeTBVX3lvdV9JX2RvbnRfbGlrZV95b3VyX2Jhc2U2NF9lbmNvZGluZ30=
~~~~

5. Report *at least* one flag hidden in `greetz.fpff`. Any other flag found will count as bonus points towards the *competition* portion of the syllabus.

~~~~
CMSC389R-{h0pefully_y0u_didnt_grep_CMSC389R}
CMSC389R-{w3lc0me_b@ck_fr0m_spr1ng_br3ak}
~~~~
