# Responsible for order summary
require 'order'

describe Order do
  let(:cart) { {'VS5' => 10} }
  let(:inventory) { {
    'VS5' => {:packs => [{:quantity => 3, :price => 6.99}, {:quantity => 5, :price => 8.99}]}
  } }
  let(:selected_packs) { {'VS5' => {5 => 2}} }

  describe '.summarize' do
    it 'should return "No option" for empty input' do
      expect(Order.new(cart, {'VS5' => {}}, {}).summarize).to eq('No option')
    end

    it 'should return order summary for valid input' do
      expect(Order.new(cart, selected_packs, inventory).summarize)
        .to eq("10 VS5 - $17.98
          2 x 5 $8.99")
    end
  end

  describe '.pricing_info' do
    it 'should return order summary for valid input' do
      expect(Order.new(cart, selected_packs, inventory).pricing_info('VS5'))
        .to eq({:total_price=>17.98, :cost_breakup=>["2 x 5 $8.99"]})
    end
  end
end