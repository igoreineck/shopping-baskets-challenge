require_relative 'item'
require_relative '../services/checkout_calculator'

module Entities
  class ShoppingBasket
    def initialize
      @basket = {
        entries: [],
        taxes: 0.0,
        total: 0.0
      }
    end

    attr_reader :basket

    def add_entries(entries:)
      entries.each do |entry|
        @basket[:entries] << { item: Item.new(entry) }
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
      return if @basket[:entries].empty?

      @basket[:entries].each do |entry|
        entry[:tax], entry[:total] = Services::CheckoutCalculator.call(entry[:item])

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
