module Services
  class TaxCalculator
    SALES_TAX_PERCENTAGE = 10
    IMPORT_TAX_PERCENTAGE = 5
    PRODUCT_TYPES_FREE_FROM_TAX_SALES = ['book', 'food', 'medical']

    def self.calculate(item)
      tax_rate = calculate_tax_rate(item)
      tax_amount = calculate_tax_amount(item, tax_rate)
      total = calculate_total(item, tax_amount)

      [tax_amount, total]
    end

    private

    def self.calculate_tax_rate(item)
      result = 0.0
      result += SALES_TAX_PERCENTAGE unless PRODUCT_TYPES_FREE_FROM_TAX_SALES.include?(item.type)
      result += IMPORT_TAX_PERCENTAGE if item.imported?

      return result if result.zero?

      result / 100
    end

    def self.calculate_tax_amount(item, tax_rate)
      item.price * tax_rate
    end

    def self.calculate_total(item, tax_amount)
      item.price + tax_amount
    end
  end

end
