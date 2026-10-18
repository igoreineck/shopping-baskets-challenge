require './src/entities/item'
require './src/services/checkout_calculator'

RSpec.describe Services::CheckoutCalculator do
  let(:item) { Entities::Item.new(item_attributes) }

  describe '#call' do
    context 'when a product has sales and import taxes applied' do
      let(:item_attributes) do
        {
          "item-name" => 'bottle of perfume',
          "item-type" => 'personal-care',
          "imported" => true,
          "unit-price" => 27.99,
          "quantity" => 1
        }
      end

      it 'returns the tax and the total correctly' do
        tax, total = described_class.call(item)

        expect(tax).to eq(4.2)
        expect(total).to eq(32.19)
      end
    end

    context 'when a product has sales and import taxes applied in multiple units' do
      let(:item_attributes) do
        {
          "item-name" => 'bottle of perfume',
          "item-type" => 'personal-care',
          "imported" => true,
          "unit-price" => 27.99,
          "quantity" => 3
        }
      end

      it 'returns the tax and the total correctly' do
        tax, total = described_class.call(item)

        expect(tax).to eq(12.6)
        expect(total).to eq(96.57)
      end
    end

    context 'when a product has NO taxes applied' do
      let(:item_attributes) do
        {
          "item-name" => 'strawberry cheesecake',
          "item-type" => 'food',
          "imported" => false,
          "unit-price" => 15.00,
          "quantity" => 1
        }
      end

      it 'does NOT return any taxes applied' do
        tax, total = described_class.call(item)

        expect(tax).to eq(0)
        expect(total).to eq(15)
      end
    end
  end
end
