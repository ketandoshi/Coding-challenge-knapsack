# Responsible for representing a product
require 'product_pack'

describe ProductPack do
  subject(:product_pack) { described_class.new }
  let(:product) { Product.new('Vegemite Scroll', 'VS5') }

  describe '#add_product_pack' do
    it 'raises an exception if the product is invalid' do
      expect { product_pack.add_product_pack(nil, 3, 6.99) }
        .to raise_exception(StandardError, 'Invalid input: , 3, 6.99')
    end

    it 'should return a valid ProductPack for valid input' do
      expect { product_pack.add_product_pack(product, 3, 6.99) }.to_not raise_exception
    end
  end

  describe '.inventory' do
    subject(:product_pack) { described_class.new }
    let(:product) { Product.new('Vegemite Scroll', 'VS5') }

    it 'should return a valid ProductPack inventory for valid input' do
      product_pack.add_product_pack(product, 3, 6.99)
      expect(product_pack.inventory).to eq({"VS5"=>[{:quantity=>3, :price=>6.99}]})
    end
  end
end
