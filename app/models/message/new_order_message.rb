class NewOrderMessage < Message
  include Redis::Objects

  value :order_id

  def order
    @order ||= Order.find(order_id.value)
  end
end
