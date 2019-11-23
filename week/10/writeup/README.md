# Writeup 10 - Crypto I

Name: Marco Roxas
Section: 0101

I pledge on my honor that I have not given or received any unauthorized assistance on this assignment or examination.

Digital acknowledgement: Marco Roxas


## Assignment details

### Part 1 (45 Pts)

1. What is the structure of the ledger file format? Include exact byte offsets when static.

~~~~
offset  0: start of 16-byte hash of the 2-byte key
offset 16: start of 16-byte hash of the ciphertext
offset 32: start of 16-byte IV
offset 48: start of ciphertext
~~~~

2. What specific cryptographic implementations are used by the program? I.e. not "hashing", but a specific algorithm. Why might this pose a risk?

MD5 for hashes, AES-128 for symmetric-key encryption and decryption. There are more secure algorithms such as SHA256 for hashes and AES-256 CBC. Also by using symmetric-key algorithms the key has to be pre-shared somehow, which risks disclosure.

3. What information, if any, are you able to derive from [ledger.bin](ledger.bin) without decrypting it at all?

The MD5 hash of the hash of the password, the initial vector, and the approximate length of the plaintext perhaps.

4. How does the application ensure Confidentiality? How is the encryption key derived?

By encrypting the message with a symmetric-key algorithm. The encryption key is the first two bytes of the MD5 hash of the original passcode.

5. How does the application ensure Integrity? Is this flawed in any way?

By storing the hash of the encrypted message (ie, the ciphertext). This is flawed because the ciphertext is hashed, not the plaintext. In addition the hash can be replaced altogether alongside the ciphertext.

6. How does the application ensure Authenticity? Is this flawed in any way?

By being based on symmetric-key encryption it's assumed that only the communicating parties can encrypt and decrypt the message. But it's flawed because the sender cannot authenticate that the message isn't from themselves, and only the first two bytes of the MD5 hash f the password is used, which effectively gives an attacker the password and can act as one of the parties.

7. How is the initialization vector generated and subsequently stored? Are there any issues with this implementation?

It's randomly generated and stored as is. The IV is typically stored in this manner but should not be reused as implemented.

### Part 2 (45 Pts)

1. Develop the crack utility in a language of your choice..

First in order to compile ledger.c, `sudo apt install libssl-dev` was run (which installed 1.1.0l). But on a recent Kali version I kept getting compilation errors so I used a 32-bit version of Debian which worked. Ubuntu on WSL worked as well.

Then by looking at `ledger.c` it can be seen that the passcode is hashed, but only the first two bytes are hashed subsequently to produce the stored passcode hash. As such the search space has been reduced to 256^2 = 65536; thus to reverse the process it's only necessary to find 65536 passcodes whose first two bytes of their md5 hash range from 0..65536 (ie, when interpreted as a 16-bit unsigned number).

The table to reverse the hash is called a rainbow table; two can be used but it can also be just one. In this case two were used for ease of implementation.

After some hacking and trial-and-error, I arrived at the following process:

Generate one rainbow table by hashing lines of the `rockyou.txt` wordlist and inspecting the first two bytes of the hash and taking only 65536 unique ones. Two perl one-liners were written and placed in the `Makefile` as a pipeline which perform this type of filtering. These unique hash/password pairs are saved in `crack.rb` for later use. `rockyou_command.sh` was added to locate the wordlist.

Generate another rainbow table by hashing the range 0..65536. This was written as a one-liner in `crack.rb` (other lines are there to read `ledger.bin` among other things)

Finally read off the MD5 hash of `ledger.bin` and consult the two rainbow tables to essentially reverse the process and arrive at a sample passcode to use. The flag is then decrypted.

`ledger` can be run using `crack` with backticks or alternatively as `./ledger $(writeup/crack)` 

Also some explanations were added to `Makefile` and `crack.rb`

2. What is the flag?

~~~~
CMSC389R-{k3y5p4c3_2_sm411}
~~~~

### Part 3 (10 Pts)

While most will probably argue that there is no security by obscurity, I've certainly seen many cases where security by obscurity succeeded despite its apparent insecurity. A few examples would be hiding a house key in a secret spot temporarily for a relative who's forgotten their key and cannot get in, writing down part of a password on a piece of paper (the rest of the pasword cannot be guessed easily), and finding a lost wallet that thankfully no one else has noticed.

I could argue then that an ideal balance could lie a little further away from Kirchoff's principle towards security by obscurity if the risk can be mitigated by the period of time (ie, it's a brief or temporary event) and a good level of difficulty in exploring a search space whether systematically or via some heuristic, or if what's being protected isn't worthwhile to others (ie, other people either don't care or busy doing something else). But I would add that the risk increases dramatically in the presence of automation (eg, electronic) or if the attacker is well-funded or determined.

One counter-argument is from an apocryphal story: Law enforcement was set to release an apprehended individual known to coordinate criminal activity with their cell phone, which has a secure and difficult-to-remember passcode.

The story goes that the individual has placed a cryptic version of each character of their passcode in random places over their tatoo-covered body as a form of security by obscurity; yet the cybersecurity team was able to figure this out in time to obtain the correct passcode and incriminate the individual.

However legend has it that the correct passcode was obtained through other means; and mysteriously enough involved either a rubber hose and/or feathers.
