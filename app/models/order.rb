class Order < ActiveRecord::Base
  attr_accessible :bid, :charID, :duration, :minVolume, :orderID, :orderState, :price, :range, :stationID, :typeID, :volEntered, :volRemaining

  def item_title
    api = EveApi.new
    api.type_name(typeID)
  end

  def self.update_orders
    api = EveApi.new
    orders = api.orders
    changes = {}
    orders.each do |order|
      order_attributes = get_attributes(order) 
      if db_order = Order.find_by_orderID(order.orderID) # Existing order
        db_order.assign_attributes(order_attributes)
        if db_order.changed?
          changes[order.orderID] = db_order.changes
          self.send_change_notification(db_order)
          db_order.save
        end
      else # New order
        new_order = Order.new(order_attributes)
        new_order.save
        self.send_new_notification(new_order)
      end
    end
  end

private

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

    self.send_to_users(message)
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

    self.send_to_users(message)
  end

  def self.send_to_users(message)
    users = User.all
    users.each do |user|
      user.notify(message)
    end
  end

end
