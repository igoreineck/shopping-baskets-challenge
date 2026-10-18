module Services
  class TaxCalculator
    SALES_TAX = 0.10 # 10 / 100
    IMPORT_TAX = 0.05 # 5 / 100
    ROUNDING_FACTOR = 20.0 # 1 / 0.05 (rounding increment)

    PRODUCT_TYPES_FREE_FROM_TAX_SALES = ['book', 'food', 'medication']

    def self.calculate(item)
      tax_rate = calculate_tax_rate(item.type, item.imported)
      tax = round_tax(item.unit_price * tax_rate)
      total = calculate_total(item.unit_price, tax, item.quantity)

      [tax * item.quantity, total]
    end

    private

    def self.calculate_tax_rate(item_type, item_imported)
      result = 0.0
      result += SALES_TAX unless PRODUCT_TYPES_FREE_FROM_TAX_SALES.include?(item_type)
      result += IMPORT_TAX if item_imported
      result
    end

    def self.round_tax(tax)
      (tax * ROUNDING_FACTOR).ceil / ROUNDING_FACTOR
    end

    def self.calculate_total(unit_price, tax, quantity)
      (unit_price + tax) * quantity
    end
  end
end
