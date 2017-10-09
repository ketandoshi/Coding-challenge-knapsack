# Responsible for finding the optimize packs
require 'pack_finder'

describe PackFinder do
  let(:inventory) { {
    'VS5' => {:packs => [{:quantity => 3, :price => 6.99}, {:quantity => 5, :price => 8.99}]}
  } }
  let(:cart) { {'VS5' => 10} }

  describe '#pick_required_packs' do
    it 'should return empty result when invalid input' do
      expect(PackFinder.new(inventory).pick_required_packs({'VS5' => 1}))
        .to eq({"VS5" => {}})
    end

    it 'should return the selected packs when valid input' do
      expect(PackFinder.new(inventory).pick_required_packs(cart))
        .to eq({"VS5" => {5 => 2}})
    end
  end
end
