# Responsible for parsing input
require 'order_request'

describe OrderRequest do
  describe '.parse' do
    it 'should return an error for non-hash input' do
      expect { described_class.parse('VS5') }.to raise_exception(StandardError, 'Invalid input: VS5')
      expect { described_class.parse('10VS5') }.to raise_exception(StandardError, 'Invalid input: 10VS5')
    end

    it 'should return an error for multiple numbers non-hash input' do
      expect { described_class.parse('10 12') }.to raise_exception(StandardError, 'Invalid input: 10 12')
    end

    it 'should return a valid OrderRequest for valid input' do
      expect(described_class.parse({'VS5' => '10'}).cart).to eq({'VS5' => 10})
      expect(described_class.parse({'vs5' => '12'}).cart).to eq({'VS5' => 12})
    end
  end
end