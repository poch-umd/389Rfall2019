#!/usr/bin/ruby

require 'digest'

FILENAME = 'ledger.bin'

def value_password_of arg
  [ arg.first[0..3].to_i(16), arg.last.chomp ]
end

rainbow_one = DATA.readlines.map { |x| value_password_of x.split("\t") }.to_h

rainbow_two = {}
(0..255).each { |x| (0..255).each { |y| rainbow_two[ Digest::MD5::hexdigest [x,y].pack 'C*' ] = (x<<8)|y } }

ledger_key = File.open( FILENAME, 'rb' ).read( 16 ).each_byte.map { |x| "%02x" % x }.join

print rainbow_one[ rainbow_two[ ledger_key ] ]

__END__
