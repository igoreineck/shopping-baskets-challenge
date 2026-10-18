require './src/entities/item'
require './src/services/tax_calculator'

RSpec.describe Services::TaxCalculator do
  let(:item_attributes) do
    {
      "item-name" => 'chocolate box A',
      "item-type" => 'food',
      "imported" => false,
      "unit-price" => 10.00,
      "quantity" => 2
    }
  end

  let(:item) { Entities::Item.new(item_attributes) }

  describe '#calculate' do
    context 'when the product is eligible for sales taxes' do
      let(:item_attributes) do
        {
          "item-name" => 'bottle of perfume',
          "item-type" => 'personal-care',
          "imported" => false,
          "unit-price" => 10.00,
          "quantity" => 1
        }
      end

      it 'returns a tax of 10% on top of the unit price' do
        expect(described_class.calculate(item)).to eq(1.0)
      end
    end

    context 'when the product is eligible for import taxes' do
      let(:item_attributes) do
        {
          "item-name" => 'box of chocolate',
          "item-type" => 'food',
          "imported" => true,
          "unit-price" => 10.00,
          "quantity" => 1
        }
      end

      it 'returns a tax of 5% on top of the unit price' do
        expect(described_class.calculate(item)).to eq(0.5)
      end
    end

    context 'when the product is eligible for both taxes' do
      let(:item_attributes) do
        {
          "item-name" => 'bottle of perfume',
          "item-type" => 'personal-care',
          "imported" => true,
          "unit-price" => 27.99,
          "quantity" => 1
        }
      end

      it 'returns a tax of 15% on top of the unit price' do
        expect(described_class.calculate(item)).to eq(4.2)
      end
    end

    context 'when the product is NOT eligible for any taxes' do
      let(:item_attributes) do
        {
          "item-name" => 'packet of headache pills',
          "item-type" => 'medication',
          "imported" => false,
          "unit-price" => 10.00,
          "quantity" => 1
        }
      end

      it 'returns a tax of 0%' do
        expect(described_class.calculate(item)).to eq(0.0)
      end
    end
  end

  # @TODO: maybe add test cases to catch rounding issues.
end
