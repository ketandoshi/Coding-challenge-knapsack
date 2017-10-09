class Order
  attr_reader :cart, :summary, :inventory

  def initialize(cart, summary, inventory)
    @cart = cart
    @summary = summary
    @inventory = inventory
  end

  def summarize
    return 'No option' if @summary.values.reduce({}, :merge).empty?
    result = []
    spacer = ' ' * 10

    @cart.each do |code, order_qty|
      pricing = pricing_info(code)
      result << "#{order_qty} #{code} - $#{pricing[:total_price].round(2)}"
      pricing[:cost_breakup].each {|x| result << (spacer + x)}
    end

    result.join("\n")
  end

  def pricing_info(code)
    pricing = Hash.new
    @inventory[code][:packs].each {|pack_info| pricing[pack_info[:quantity]] = pack_info[:price]}

    price_details = {total_price: 0.0, cost_breakup: []}

    @summary[code].each do |pack, pack_qty|
      price_details[:total_price] += (pricing[pack] * pack_qty)
      price_details[:cost_breakup] << "#{pack_qty} x #{pack} $#{pricing[pack]}"
    end

    price_details
  end
end
