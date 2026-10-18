class EntryCalculator
  SALES_TAX = 0.10 # 10%
  IMPORT_TAX = 0.05 # 5%
  PRODUCTS_FREE_FROM_TAX_SALES = ['book', 'food', 'medical']

  def initialize(entry)
    @entry = entry
    @tax_rate = 0.0
    @price = 0.0
    @tax_amount = 0.0
  end

  def calculate
    calculate_tax_rate
    calculate_price
    calculate_tax_amount

    [@tax_amount, @price]
  end

  private

  def calculate_tax_rate
    @tax_rate += SALES_TAX unless PRODUCTS_FREE_FROM_TAX_SALES.include?(@entry[:item].type)
    @tax_rate += IMPORT_TAX if @entry[:item].imported?
  end

  def calculate_price
    @price = @entry[:quantity] * (@entry[:item].unit_price * (1 + @tax_rate))
  end

  def calculate_tax_amount
    @tax_amount = @price * @tax_rate
  end
end
