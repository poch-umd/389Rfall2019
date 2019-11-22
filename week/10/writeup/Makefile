PCT := %

ROCKYOU_GZ=/usr/share/wordlists/rockyou.txt.gz
ROCKYOU_TX=../rockyou.txt

ROCKYOU_CMD=wget -qO-
ROCKYOU_GH=https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

# The -nl options in Perl trigger its line-by-line reading
# The $$ and $(PCT) escape the $ and % in the Makefile
#
# The !$hash{$1}++ on the second Perl one-liner returns true only
#   when the hash is empty for that slot, so the ensuing and print..
#   only executes the first time that slot is saved. This script
#   also makes a quick exit if enough hashes have been collected
#
#	if [ -f $(ROCKYOU_GZ) ]; then zcat $(ROCKYOU_GZ); else wget -qO- $(ROCKYOU_GH); fi |
#	  this command could've been used to switch between password lists but it
#   reads in the entire file, I'm sure there's another way to make it read line by line
#
# Also, the two one-liners can be refactored into just one except it'll be long and
# I think won't execute in parallel 
#
# The resulting list of tab-delimited md5 hashes and their corresponding
# alphanumeric passcodes are fed into crack.rb which uses it as
# a rainbow table

#$(ROCKYOU_CMD) $(ROCKYOU_GH) | \
#cat $(ROCKYOU_TX) | \

crack: crack.rb FORCE
	cp crack.rb crack
	./rockyou_command.sh | \
  perl -wnl -M'Digest::MD5 qw( md5_hex)' -e '/^[a-zA-Z0-9]+$$/ and print(md5_hex($$_),"\t", $$_)' | \
  perl -wnl -e 'BEGIN { $(PCT)hash } /^(.{4}).*?\t(.*?)$$/ and !$$hash{$$1}++ and print and scalar keys $(PCT)hash == 65536 and exit' | \
  sort >> crack

FORCE:

clean:
	rm -rf crack

all: crack

.PHONY=clean FORCE
.DEFAULT_GOAL=crack
