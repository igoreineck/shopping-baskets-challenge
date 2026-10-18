require 'optparse'
require 'pry'
require_relative 'helpers/parser'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on("--FILE", "--file=FILE", "Input a file path") do |file|
    options[:file] = file
  end

  opts.on("-h", "--help", "Help") do
    puts opts
    exit
  end
end.parse!

Helpers::Parser.parse_file(file_name: options[:file]) if options.key?(:file)
