# Responsible for representing a product
require 'product'

describe Product do
  let(:product) { described_class.new('Vegemite Scroll', 'VS5') }

  describe '.name' do
    subject { product.name }

    it { is_expected.to eq('Vegemite Scroll') }
  end

  describe '.code' do
    subject { product.code }

    it { is_expected.to eq('VS5') }
  end
end
