require_relative 'entry_calculator'
require_relative 'item'

class ShoppingBasket
  def initialize
    @entries = []
    @sales_taxes = 0.0
    @amount = 0.0
  end

  attr_reader :entries, :total

  # { item:, quantity:, tax:, price:}
  def add_entry(entry_attributes, quantity)
    @entries << { item: Item.new(entry_attributes), quantity: }
  end

  def add_entries(entries: [])
    entries.map do |entry_attributes|
      add_entry(entry_attributes, entry_attributes["quantity"])
    end
  end

  def calculate_amount_to_pay
    @entries.each do |entry|
      calculator = EntryCalculator.new(entry)
      entry[:tax], entry[:price] = calculator.calculate
    end

    # @TODO: optimize this if possible
    @sales_taxes = @entries.sum { |entry| entry[:tax] }
    @amount = @entries.sum { |entry| entry[:price] }
  end

  def printer
    @entries.each do |entry|
      puts "#{entry[:quantity]} #{entry[:item].name}: #{entry[:price].round(2)}"
    end

    puts "Sales Taxes: #{@sales_taxes.round(2)}"
    puts "Total: #{@amount.round(2)}"
  end
end
