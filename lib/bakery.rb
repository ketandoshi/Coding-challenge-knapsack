class Bakery
  InvalidProduct = Class.new(StandardError)
  DuplicateProduct = Class.new(StandardError)

  attr_accessor :inventory

  def initialize
    @inventory = {}
  end

  def add_product(product, product_pack)
    raise(InvalidProduct, product) unless product.instance_of?(Product)
    raise(DuplicateProduct, "Bakery already has product: #{product.code}") if inventory.key?(product.code)

    inventory[product.code] = {
      product: product,
      packs: product_pack.inventory[product.code]
    }
  end

  def place_order(request)
    ordered_packages = PackFinder.new(inventory).pick_required_packs(
      request.cart
    )

    if ordered_packages
      Order.new(request.cart, ordered_packages, inventory).summarize
    else
      'No option from Bakery'
    end
  end
end
