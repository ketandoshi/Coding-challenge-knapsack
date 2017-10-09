require 'order_request'
require 'order'
require 'pack_finder'
require 'product'
require 'product_pack'
require 'bakery'

describe Bakery do
  subject(:bakery) { described_class.new }
  let(:vs) { Product.new('Vegemite Scroll', 'VS5') }
  let(:bm) { Product.new('Blueberry Muffin', 'MB11') }
  let(:cr) { Product.new('Croissant', 'CF') }

  subject(:product_pack) { ProductPack.new }

  describe '#add_product' do
    it 'raises an exception if the product is invalid' do
      expect { bakery.add_product(nil, nil) }
        .to raise_exception(Bakery::InvalidProduct)
    end

    it 'does not allow products with duplicate code' do
      product_pack.add_product_pack(vs, 3, 6.99)
      bakery.add_product(vs, product_pack)

      expect { bakery.add_product(vs, product_pack) }.to raise_exception(Bakery::DuplicateProduct)
    end

    it 'allows products with different codes' do
      product_pack.add_product_pack(vs, 3, 6.99)
      product_pack.add_product_pack(bm, 2, 9.95)
      bakery.add_product(vs, product_pack)

      expect { bakery.add_product(bm, product_pack) }.to_not raise_exception
    end
  end

  describe '#place_order' do
    it 'returns "No option" when there are no products' do
      product_pack.add_product_pack(vs, 3, 6.99)
      product_pack.add_product_pack(vs, 5, 8.99)
      bakery.add_product(vs, product_pack)

      expect { bakery.place_order(OrderRequest.parse('VS5')) }
        .to raise_exception(StandardError, 'Invalid input: VS5')
      expect(bakery.place_order(OrderRequest.parse({'VS5' => '1'})))
        .to eq('No option')
    end

    it 'returns the pack that has the right number of quantity' do
      product_pack.add_product_pack(vs, 3, 6.99)
      bakery.add_product(vs, product_pack)

      expect(bakery.place_order(OrderRequest.parse({'VS5' => '3'})))
        .to eq("3 VS5 - $6.99
          1 x 3 $6.99")
    end

    it 'returns multiple pack that has the right number of quantity' do
      product_pack.add_product_pack(vs, 3, 6.99)
      product_pack.add_product_pack(vs, 5, 8.99)
      bakery.add_product(vs, product_pack)

      expect(bakery.place_order(OrderRequest.parse({'VS5' => '14'})))
        .to eq("14 VS5 - $29.96
          1 x 5 $8.99
          3 x 3 $6.99")
    end
  end

end
