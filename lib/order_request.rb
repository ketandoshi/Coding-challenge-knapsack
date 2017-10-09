class OrderRequest
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def self.parse(input)
    input_ = {}
    input.each {|code, qty| input_[code.upcase] = qty.to_i}
    OrderRequest.new(input_)
  rescue StandardError
    raise StandardError, "Invalid input: #{input}"
  end
end
