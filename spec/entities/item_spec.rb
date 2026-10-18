require './src/entities/item'

RSpec.describe Entities::Item do
  describe '#initialize' do
    let(:item_attributes) do
      {
        "item-name" => 'chocolate box A',
        "item-type" => 'food',
        "imported" => false,
        "unit-price" => 10.00,
        "quantity" => 2
      }
    end

    let(:item) { described_class.new(item_attributes) }

    it 'returns the object structure correctly' do
      expect(item).to have_attributes(
        name: 'chocolate box A',
        type: 'food',
        imported: false,
        unit_price: 10.00,
        quantity: 2
      )
    end

    it 'returns the imported call as expected' do
      expect(item.imported?).to eq(false)
    end

    context 'when an imported product is initialized' do
      let(:item_attributes) do
        {
          "item-name" => 'chocolate box A',
          "item-type" => 'food',
          "imported" => true,
          "unit-price" => 10.00,
          "quantity" => 1
        }
      end

      it 'shows it is imported' do
        expect(item.imported?).to eq(true)
      end
    end
  end
end
