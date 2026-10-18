require 'optparse'
require 'pry'
require_relative 'src/parser'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on("--FILE", "--file=FILE", "Input the file name") do |file|
    options[:file] = file
  end

  opts.on("-h", "--help", "Help") do
    puts opts
    exit
  end
end.parse!

Parser.parse_file(file_name: options[:file]) if options.key?(:file) # I may adjust this to accept directly a file instead of a list
