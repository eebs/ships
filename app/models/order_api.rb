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

  def update_orders
    update_api_orders
    update_db_orders
  end

  def update_api_orders
    api = OrderApi.new
    orders = api.orders
    orders.each do |order|
      update_changes(order)
    end
  end

  def update_db_orders
    orders = Order.open
    api = OrderApi.new
    orders.each do |db_order|
      if api_order = api.order_by_id(db_order.orderID)
        update_changes(api_order, db_order)
      end
    end
  end

private

  def update_changes(api_order, db_order = nil)
    order_attributes = get_attributes(api_order) 
    db_order ||= Order.find_by_orderID(api_order.orderID)
    changes = {}
    if db_order # Existing order
      db_order.assign_attributes(order_attributes)
      if db_order.changed?
        changes[api_order.orderID] = db_order.changes
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
    message = Message.new
    message.title = "New order found for #{order.item_title}"
    message.body = "Listed at #{order.price}."
    message.save

    send_to_admins(message)
  end

  def send_change_notification(order)
    message = Message.new
    message.title = "Order for #{order.item_title} has changed"
    body = "Summary:\n"
    order.changes.each do |field, change|
      line = "#{field} changed from #{change[0]} to #{change[1]}\n"
      body += "#{line}"
    end
    message.body = body
    message.save

    send_to_admins(message)
  end

  def send_to_admins(message)
    characters = Character.where(:admin => true)
    characters.each do |characters|
      characters.notify(message)
    end
  end
end
