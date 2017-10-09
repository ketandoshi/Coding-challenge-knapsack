require 'optparse'
require_relative '../lib/order'
require_relative '../lib/order_request'
require_relative '../lib/pack_finder'
require_relative '../lib/product'
require_relative '../lib/product_pack'
require_relative '../lib/bakery'


def setup_bakery
  vs = Product.new('Vegemite Scroll', 'VS5')
  bm = Product.new('Blueberry Muffin', 'MB11')
  cr = Product.new('Croissant', 'CF')

  product_pack = ProductPack.new
  product_pack.add_product_pack(vs, 3, 6.99)
  product_pack.add_product_pack(vs, 5, 8.99)

  product_pack.add_product_pack(bm, 2, 9.95)
  product_pack.add_product_pack(bm, 5, 16.95)
  product_pack.add_product_pack(bm, 8, 24.95)

  product_pack.add_product_pack(cr, 3, 5.95)
  product_pack.add_product_pack(cr, 5, 9.95)
  product_pack.add_product_pack(cr, 9, 16.99)

  bakery = Bakery.new
  bakery.add_product(vs, product_pack)
  bakery.add_product(bm, product_pack)
  bakery.add_product(cr, product_pack)
  bakery
end

bakery = setup_bakery

puts "Enter product code & quantity (space separated):"

ARGF.each do |line|
  # cart = Hash[*line.split(' ')]
  # puts bakery.place_order(OrderRequest.parse(cart))
  begin
    cart = Hash[*line.split(' ')]
    puts '---Order Summary---'
    puts bakery.place_order(OrderRequest.parse(cart))
  rescue StandardError
    p 'No option'
  end
end
