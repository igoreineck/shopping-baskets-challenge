module Entities
  # This entity holds the item attributes
  class Item
    def initialize(attributes)
      @name = attributes["item-name"]
      @type = attributes["item-type"]
      @imported = attributes["imported"]
      @unit_price = attributes["unit-price"]
      @quantity = attributes["quantity"]
    end

    attr_reader :name, :type, :imported, :unit_price, :quantity

    def imported?
      @imported
    end
  end
end
