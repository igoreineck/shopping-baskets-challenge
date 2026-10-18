require_relative '../entities/item'
require_relative 'tax_calculator'

module Services
  class ShoppingBasket
    def initialize
      @basket = {
        entries: [],
        taxes: 0.0,
        total: 0.0
      }
    end

    def add_entries(entries:)
      entries.each do |entry|
        @basket[:entries] << { item: Entities::Item.new(entry) }
      end
    end

    def process_checkout
      calculate_taxes
    end

    def print
      display_input
      display_output
    end

    private

    def calculate_taxes
      @basket[:entries].each do |entry|
        entry[:tax], entry[:total] = TaxCalculator.calculate(entry[:item])

        @basket[:taxes] += entry[:tax]
        @basket[:total] += entry[:total]
      end
    end

    def display_input
      puts "Input"
      puts "------"

      @basket[:entries].each do |entry|
        puts "#{entry[:item].quantity} #{entry[:item].imported? ? 'imported' : ''} #{entry[:item].name} at #{entry[:item].unit_price}"
      end
    end

    def display_output
      puts "\nOutput"
      puts "------"

      @basket[:entries].each do |entry|
        puts "#{entry[:item].quantity} #{entry[:item].imported? ? 'imported' : ''} #{entry[:item].name}: #{entry[:total].round(2)}"
      end

      puts "Sales Taxes: #{@basket[:taxes].round(2)}"
      puts "Total: #{@basket[:total].round(2)}"
    end
  end
end
