class PackFinder
  def initialize(inventory)
    @inventory = inventory
  end

  def pick_required_packs(cart)
    @best_packs = Hash.new(0)
    cart.each_key {|key| @best_packs[key] = Hash.new(0)}
    find_packs(@inventory, cart)
    @best_packs
  end

  private

  def find_packs(inventory, cart)
    cart.each do |product_code, order_qty|
      packs = []
      inventory[product_code][:packs].each {|pi| packs << pi[:quantity]}
      find_packs_for_product(order_qty, packs, product_code)
    end
  end

  def find_packs_for_product(order_qty, packs, product_code)
    packs.sort! { |x,y| y <=> x }

    picked_packs = Hash.new do |hash, order_qty|
      if order_qty < packs.min
        []
      elsif packs.include?(order_qty)
        [order_qty]
      else
        packs.
          reject { |pack| pack > order_qty }.
          inject([]) {|selected_packs, pack| selected_packs.any? {|x| x%pack == 0} ? selected_packs : selected_packs+[pack]}.
          map { |pack| [pack] + hash[order_qty - pack] }.
          reject { |selected_packs| selected_packs.inject(0) {|sum,x| sum + x } != order_qty }.
          min { |a, b| a.size <=> b.size } || []
      end
    end

    picked_packs[order_qty].each {|x| @best_packs[product_code][x] += 1}
  end

end
