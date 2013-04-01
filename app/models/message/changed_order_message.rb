class ChangedOrderMessage < Message
  include Redis::Objects

  value :order_id
  value :changes, :marshal => true

  def order
    @order ||= Order.find(order_id.value)
  end
end
