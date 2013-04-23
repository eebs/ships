class OrderApi < EveApi

  def initialize
    @params = [
      :bid,
      :charID,
      :duration,
      :minVolume,
      :orderID,
      :orderState,
      :price,
      :range,
      :stationID,
      :typeID,
      :volEntered,
      :volRemaining,
    ]
  end

  def orders
    api.scope = 'corp'
    orders = api.MarketOrders.orders
    # Only fetch sell orders
    orders.reject { |e| e.bid != '0' }
  end

  def open_orders
    # Reject all orders that are not open
    orders.reject { |e| e.orderState != '0' }
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

  def update_orders
    update_api_orders
    update_db_orders
  end

  def update_api_orders
    orders.each do |order|
      update_changes(order)
    end
  end

  def update_db_orders
    Order.open.each do |db_order|
      if api_order = order_by_id(db_order.orderID)
        update_changes(api_order, db_order)
      end
    end
  end

private

  def update_changes(api_order, db_order = nil)
    order_attributes = get_attributes(api_order) 
    db_order ||= Order.find_by_orderID(api_order.orderID)
    if db_order # Existing order
      db_order.assign_attributes(order_attributes)
      if db_order.changed?
        send_change_notification(db_order)
        db_order.save
      end
    else # New order
      new_order = Order.new(order_attributes)
      new_order.save
      send_new_notification(new_order)
    end
  end

  def get_attributes(order)
    attributes = {}
    @params.each do |p|
      attributes[p] = order.send(p)
    end
    attributes
  end

  def send_new_notification(order)
    notifier = Notifier.new :admins

    message = NewOrderMessage.create!(:title => "New order found for #{order.item_title}")
    message.order_id = order.id

    notifier.message = message
    notifier.send
  end

  def send_change_notification(order)
    notifier = Notifier.new :admins

    message = ChangedOrderMessage.create!(:title => "Order for #{order.item_title} has changed")
    message.order_id = order.id
    message.changes = order.changes

    notifier.message = message
    notifier.send
  end
end
