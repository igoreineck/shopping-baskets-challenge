require_relative 'tax_calculator'

module Services
  # This class computes the final price for each product and taxes involved in the checkout.
  class CheckoutCalculator
    def self.call(item)
      tax = TaxCalculator.calculate(item)
      total = calculate_total(item.unit_price, tax, item.quantity)

      [(tax * item.quantity).round(2), total.round(2)]
    end

    private

    def self.calculate_total(unit_price, tax, quantity)
      (unit_price + tax) * quantity
    end
  end
end
