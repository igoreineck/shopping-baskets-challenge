require './src/entities/item'
require './src/entities/shopping_basket'
require './src/services/checkout_calculator'

RSpec.describe Entities::ShoppingBasket do
  let(:shopping_basket) { described_class.new }

  it 'returns an empty list of entries' do
    expect(shopping_basket.basket[:entries].size).to eq(0)
  end

  describe '#add_entries' do
    let(:items) do
      [
        { "item-name": "Book", "item-type": "book", "quantity": 2, "imported": false, "unit-price": 12.49 },
        { "item-name": "music CD", "item-type": "music", "quantity": 1, "imported": false, "unit-price": 14.99 },
        { "item-name": "chocolate bar", "item-type": "food", "quantity": 1, "imported": false, "unit-price": 0.85 }
      ]
    end

    it 'returns a list with valid entries' do
      shopping_basket.add_entries(entries: items)

      expect(shopping_basket.basket[:entries].size).to eq(3)
    end
  end

  describe '#process_checkout' do
    context 'input 1' do
      let(:items) do
        [
          { "item-name" => "Book", "item-type" => "book", "quantity" => 2, "imported" => false, "unit-price" => 12.49 },
          { "item-name" => "music CD", "item-type" => "music", "quantity" => 1, "imported" => false, "unit-price" => 14.99 },
          { "item-name" => "chocolate bar", "item-type" => "food", "quantity" => 1, "imported" => false, "unit-price" => 0.85 }
        ]
      end

      before do
        shopping_basket.add_entries(entries: items)
        shopping_basket.process_checkout
      end

      it 'returns a list size as expected' do
        expect(shopping_basket.basket[:entries].size).to eq(3)
      end

      it 'returns the tax amount as expected' do
        expect(shopping_basket.basket[:taxes]).to eq(1.50)
      end

      it 'returns the total as expected' do
        expect(shopping_basket.basket[:total]).to eq(42.32)
      end
    end

    context 'input 2' do
      let(:items) do
        [
          { "item-name" => "box of chocolates", "item-type" => "food", "quantity" => 1, "imported" => true, "unit-price" => 10.00 },
          { "item-name" => "bottle of perfume", "item-type" => "personal-care", "quantity" => 1, "imported" => true, "unit-price" => 47.50 }
        ]
      end

      before do
        shopping_basket.add_entries(entries: items)
        shopping_basket.process_checkout
      end

      it 'returns a list size as expected' do
        expect(shopping_basket.basket[:entries].size).to eq(2)
      end

      it 'returns the tax amount as expected' do
        expect(shopping_basket.basket[:taxes]).to eq(7.65)
      end

      it 'returns the total as expected' do
        expect(shopping_basket.basket[:total]).to eq(65.15)
      end
    end

    context 'input 3' do
      let(:items) do
        [
          { "item-name" => "bottle of perfume", "item-type" => "personal-care", "quantity" => 1, "imported" => true, "unit-price" => 27.99 },
          { "item-name" => "bottle of perfume", "item-type" => "personal-care", "quantity" => 1, "imported" => false, "unit-price" => 18.99 },
          { "item-name" => "packet of headache pills", "item-type" => "medication", "quantity" => 1, "imported" => false, "unit-price" => 9.75 },
          { "item-name" => "boxes of chocolates", "item-type" => "food", "quantity" => 3, "imported" => true, "unit-price" => 11.25 }
        ]
      end

      before do
        shopping_basket.add_entries(entries: items)
        shopping_basket.process_checkout
      end

      it 'returns a list size as expected' do
        expect(shopping_basket.basket[:entries].size).to eq(4)
      end

      it 'returns the tax amount as expected' do
        expect(shopping_basket.basket[:taxes].round(2)).to eq(7.90)
      end

      it 'returns the total as expected' do
        expect(shopping_basket.basket[:total]).to eq(98.38)
      end
    end
  end
end
