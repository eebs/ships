class OrderApi < EveApi

  def orders
    api.scope = 'corp'
    orders = api.MarketOrders.orders
    # Only fetch sell orders
    orders.reject! { |e| e.bid != '0' }
    orders
  end

  def open_orders
    # Reject all orders that are not open
    orders.reject! { |e| e.orderState != '0' }
  end

  def order_by_id(orderID)
    api.scope ='corp'
    begin
      market_orders = api.MarketOrders('orderID' => orderID)
      orders = market_orders.orders
      return orders.first
    rescue EveAPIException532 => e # Catch order not found
      return nil
    end
  end

  def next_update
    api.scope = 'corp'
    Time.zone.parse(api.MarketOrders.cached_until)
  end
end
