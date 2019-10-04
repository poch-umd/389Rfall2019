#!/usr/bin/ruby

class CdDir
  attr_reader :path

  # internally should have an absolute path
  def path= path_to_set
    if path_to_set.size == 0 then
      return
    end

    path_components = path_to_set.split('/') - [ '' ]

    if path_to_set =~ /^\s*\/.*?$/
      @path_components = path_components if path_components
      @path = path_to_set
    else
      puts "relative path"
      # alter the stored path to include the new path
      @path_components ||= []
      @path_components = @path_components + path_components
      @path = '/' + @path_components.join( '/' )
    end
    puts @path_components
    puts @path_components.size
  end
end

m = CdDir.new
m.path = ARGV.first || "    ////hi"
puts m.path
