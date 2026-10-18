require_relative '../entities/item'
require_relative 'tax_calculator'

module Services
  class ShoppingBasket
    def initialize
      @entries = []
      @sales_taxes = 0.0
      @amount = 0.0
    end

    def add_entry(entry_attributes)
      @entries << { item: Entities::Item.new(entry_attributes) }
    end

    def add_entries(entries: [])
      entries.map { |entry_attributes| add_entry(entry_attributes) }
    end

    def process_checkout
      calculate_items
      calculate_taxes
      calculate_total
    end

    def print
      display_input
      display_output
    end

    private

    def calculate_items
      @entries.each { |entry| entry[:tax], entry[:total] = TaxCalculator.calculate(entry[:item]) }
    end

    def calculate_taxes
      @sales_taxes = @entries.sum { |entry| entry[:tax] }
    end

    def calculate_total
      @amount = @entries.sum { |entry| entry[:total] }
    end

    def display_input
      puts "Input"
      puts "------"

      @entries.each do |entry|
        puts "#{entry[:item].quantity} #{entry[:item].imported? ? 'imported' : ''} #{entry[:item].name} at #{entry[:item].unit_price}"
      end
    end

    def display_output
      puts "\nOutput"
      puts "------"

      @entries.each do |entry|
        puts "#{entry[:item].quantity} #{entry[:item].name}: #{entry[:total].round(2)}"
      end

      puts "Sales Taxes: #{@sales_taxes.round(2)}"
      puts "Total: #{@amount.round(2)}"
    end
  end
end
