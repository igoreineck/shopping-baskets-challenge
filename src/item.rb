# @TODO: review names and attributes
class Item
  def initialize(attributes)
    @name = attributes["item-name"]
    @type = attributes["item-type"]
    @imported = attributes["imported"]
    @unit_price = attributes["unit-price"]
  end

  attr_reader :name, :type, :imported, :unit_price

  def imported?
    @imported
  end
end
