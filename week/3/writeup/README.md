# Operational Security and Social Engineering Assignment

Note, this assignment was done in terms of Eric Norman (not his Mom).

### Part 1 (Question)

You have been hired by a penetration testing firm and have been asked to collect some specific information about the Wattsamp employee from HW2, Eric Norman. Some of the information you're looking for seems to be unavailable or unlikely to be found through OSINT:

- What's his mother's maiden name?
- What browser does Eric primarily use?
- What city was he born in?
- What's his ATM pin number?
- What was the name of his first pet?

Write up a pretext that you would use to social engineer this information out of Eric Norman. What approach would you take and how would you present yourself to elicit this information under the radar? Use the slides and what we covered in lecture to come up with a plan to obtain this information.

### Part 1 (Answer)

The questions above look to be a perfect fit for a phishing e-mail; many websites ask for personal security questions similar to these in case the user forgets their password. As for obtaining the ATM pin number, that takes some imagination but can be combined with the phishing e-mail if the e-mail appears to be from the victim's bank or credit card.

This scheme has two parts.

The first part is to survey establishments where Eric is likely to have used a bank card. These are likely to be restaurants, supermarkets, wine shops, or automobile parts stores within a reasonable radius from Eric's home and workplace. The idea is to call these places and eventually obtain the name of the bank who issued the card.

An example would be a call to a restaurant reasonably close to where Eric works. Such a call would have me pretend that I'm Eric Norman (it's not likely for an employee to know him personally) and ask for assistance in tracking down a payment that I made. I'll say that I'm traveling out of state (which explains the different area code in caller ID) and that I vaguely remember if it was this or last month.  If a record is indeed found, I'll specifically ask "I just don't remember which credit card I used, could you tell me?"  If I receive the information (perhaps even multiple names, eg, CapitalOne and AmericanExpress, I can choose which to use) then I'll thank them for their help and time, something in the lines of "I've been pulling my hair out for the past hour on this so I really appreciate your help."

One important point is that this assumes that Eric is the only Eric J Norman in the area.

The second part is once the bank name is known (the above step will be repeated with various establishments until this is obtained), then a phishing website and e-mail will be set up to resemble the online look and feel for the named bank. It's also a big help to have an account in the named bank myself (perhaps I have accounts open in various banks just for that purpose); or simply visiting the bank's website can yield graphics and styles that are easily copied.

The phishing e-mail will read:

Subject: Help us secure your account and get $10!

It only takes less than 5 minutes to help secure your account.
(rest of convincing copy here)

(Button: Protect my account)

Sincerely,
The [Bank name] Accounts Team

The idea of course is that it can be hard to say no to free money.

Clicking on the button will take the user to a fake website with a url that that looks legitimate (eg, capitalone.secaccountteam.com) and could even use a wildcard ssl certificate.

Questions such as asking for the name of the first pet, mother's maiden name, what City Eric was born in, and some filler questions (but not the ATM pin number) are on the page.  Once the user hits the Submit button, the page asks that in order to deposit the $10 in their account, they would need to enter their ATM pin number for the card.  A 5-minute timer starts stating that the answers will be reset after 5 minutes and that they have to start over. This should create a sense of urgency in giving out the ATM pin number.

Upon entering the ATM pin number the page would then thank the user and ask them to close the browser window for security purposes.  Meanwhile the information has been collected along with the web browser that Eric was using.

Last, the $10 can usually be deposited anonymously at a local branch (I can explain that I owe Eric money) if they withhold the receipt for security purposes.
