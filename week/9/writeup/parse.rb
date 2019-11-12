#!/usr/bin/ruby

require 'date'

ARGF.binmode
SECTION_TYPES = [ '', 'ASCII', 'UTF8', 'WORDS', 'DWORDS', 'DOUBLES', 'COORD', 'REFERENCE', 'PNG', 'GIF87', 'GIF89' ]
GIF87_SIG = [ 0x47, 0x49, 0x46, 0x38, 0x37, 0x61 ]
PNG_SIG = [ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A ]

magic, version, timestamp, author, section_count = ARGF.read( 24 ).unpack 'L< L< L< A8 L<'

puts "Magic: #{magic.to_s( 16 )} Version: #{version} Timestamp: #{Time.at( timestamp ).to_datetime} Author: #{author}, Section count: #{section_count}"

1.upto( section_count ) do | section_number |
  stype, slen = ARGF.read( 8 ).unpack 'L< L<'

  if slen > 0 then
    stype = SECTION_TYPES[ stype ]

    print "Found #{section_number} #{stype} #{slen}: "
    if stype == 'ASCII'
      puts ARGF.read( slen )
    elsif stype == 'PNG'
      filename = "#{section_number}.png"
      File.open( filename, 'wb' ) { |f| f.write PNG_SIG.pack 'C*'; f.write ARGF.read( slen ) }
      puts "saved in #{filename}"
    elsif stype == 'COORD'
      latitude, longitude = ARGF.read( 16 ).unpack 'E E'
      puts "#{latitude}, #{longitude}"
    else
      puts
    end

  end

end
__END__
