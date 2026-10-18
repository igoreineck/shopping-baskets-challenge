require 'optparse'
require 'pry'
require_relative 'services/parser'

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

Services::Parser.parse_file(file_name: options[:file]) if options.key?(:file)
