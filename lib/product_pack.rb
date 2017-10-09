class ProductPack
  attr_reader :inventory

  def initialize
    @inventory = {}
  end

  def add_product_pack(product, quantity, price)
    inventory[product.code] ||= []
    inventory[product.code] << {
      quantity: quantity,
      price: price
    }
  rescue StandardError
    raise StandardError, "Invalid input: #{product}, #{quantity}, #{price}"
  end

end
