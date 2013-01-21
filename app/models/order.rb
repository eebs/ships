class Order < ActiveRecord::Base
  attr_accessible :bid, :charID, :duration, :minVolume, :orderID, :orderState, :price, :range, :stationID, :typeID, :volEntered, :volRemaining

  def item_title
    api = EveApi.new
    api.type_name(typeID)
  end

  def self.update_orders
    self.update_api_orders
    self.update_db_orders
  end

  def self.update_api_orders
    api = EveApi.new
    orders = api.orders
    orders.each do |order|
      self.update_changes(order)
    end
  end

  def self.update_db_orders
    orders = Order.where(:orderState => '0')
    api = EveApi.new
    orders.each do |db_order|
      if api_order = api.order_by_id(db_order.orderID)
        self.update_changes(api_order, db_order)
      end
    end
  end

private

  def self.update_changes(api_order, db_order = nil)
    order_attributes = get_attributes(api_order) 
    db_order ||= Order.find_by_orderID(api_order.orderID)
    changes = {}
    if db_order # Existing order
      db_order.assign_attributes(order_attributes)
      if db_order.changed?
        changes[api_order.orderID] = db_order.changes
        self.send_change_notification(db_order)
        db_order.save
      end
    else # New order
      new_order = Order.new(order_attributes)
      new_order.save
      self.send_new_notification(new_order)
    end
  end

  def self.get_attributes(order)
    attribs = {
      :bid => order.bid,
      :charID => order.charID,
      :duration => order.duration,
      :minVolume => order.minVolume,
      :orderID => order.orderID,
      :orderState => order.orderState,
      :price => order.price,
      :range => order.range,
      :stationID => order.stationID,
      :typeID => order.typeID,
      :volEntered => order.volEntered,
      :volRemaining => order.volRemaining,
    }
  end

  def self.send_new_notification(order)
    message = Message.new
    message.title = "New order found for #{order.item_title}"
    message.body = "Listed at #{order.price}."
    message.save

    self.send_to_admins(message)
  end

  def self.send_change_notification(order)
    message = Message.new
    message.title = "Order for #{order.item_title} has changed"
    body = "Summary:\n"
    order.changes.each do |field, change|
      line = "#{field} changed from #{change[0]} to #{change[1]}\n"
      body += "#{line}"
    end
    message.body = body
    message.save

    self.send_to_admins(message)
  end

  def self.send_to_admins(message)
    characters = Character.where(:admin => true)
    characters.each do |characters|
      characters.notify(message)
    end
  end

end
