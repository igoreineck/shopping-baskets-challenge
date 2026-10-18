require 'json'
require_relative 'shopping_basket'

# @TODO: improve the parser and the file input to work with a bigger lists (NICE TO HAVE)
#
class Parser
  def self.parse_file(file_name:)
    File.foreach(file_name) do |line|
      basket = ShoppingBasket.new
      basket.add_entries(entries: JSON.parse(line.strip))
      basket.calculate_amount_to_pay
      basket.printer
    rescue JSON::ParserError => error
      puts "Failed to parse line: #{line.strip}. Error: #{error.message}"
    end
  end
end
