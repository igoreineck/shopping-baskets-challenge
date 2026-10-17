require 'optparse'
require './src/parser'

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

# Ways to receive the input
#
# Initial idea:
# 1. Parser
# 2. Entity for each Item
# 3. Calculator (do I need another Tax Calculator?)
# 4. Printer or Serializer
# 5. TBD
#
# class Calculator
#   # [{ item:, quantity: 2 }, { ... }]
#   def initialize(items: [])
#     # 1. loop over each item
#     # 2. sum each item * by its quantity
#     # 3. check which item-type it belongs to, and apply taxes if applicable
#     # 4. I must know and differentiate the overall price and the price with taxes applied, to be able to show the sum of all applied taxes.
#     # x. returns the sum
#   end
# end

# Everything except books, food, and medical products that are exempt
# One way of doing this: if item-type != 'book', 'food', 'medical' -> then apply TAX
#
# The import duty is applied on top of all 'imported' items, with no exempt.

# ImportedTax
# 1. returns the tax number
# 2. returns the overall price with tax applied
#
# SalesTax
#
# TaxCalculator
