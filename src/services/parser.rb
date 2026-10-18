require 'json'
require_relative 'shopping_basket'

module Services
  class Parser
    def self.parse_file(file_name:)
      File.foreach(file_name) do |line|
        basket = ShoppingBasket.new
        basket.add_entries(entries: JSON.parse(line.strip))
        basket.process_checkout
        basket.print
      rescue JSON::ParserError => error
        puts "Failed to parse line: #{line.strip}. Error: #{error.message}"
      end
    end
  end
end
