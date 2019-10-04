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

menu = "Please enter a number:\n1. shell\n2. pull <remote-path> <local-path>\n3. help\n4. quit"
wd = CdDir.new '/'

def shell wd
  # print a shell prompt w/ the directory
  # allow the user to enter a command
  # if it's a cd command then change the CdDir
  # if it's a command then output the ; cd ; <command>
  # capture the output and show it on the screen for the user
end

def pull remote local
  # run cat on the remote
  # capture output to the local file
end

puts menu
while selection = gets.chomp do
  case selection
    when /^\s*quit\s*$/i
      break
    when /^\s*shell\s*$/i
      puts selection
    when /^\s*pull (.*?) (.*?)\s*$/i
      puts selection
    when /^\s*help\s*$/i
      puts selection
  end
  puts menu
end
