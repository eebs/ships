class Order < ActiveRecord::Base
  attr_accessible :bid, :charID, :duration, :minVolume, :orderID, :orderState, :price, :range, :stationID, :typeID, :volEntered, :volRemaining

  def self.update_orders(orders)
    changes = {}
    orders.each do |order|
      order_attributes = get_attributes(order) 
      if db_order = Order.find_by_orderID(order.orderID) # Existing order
        db_order.assign_attributes(order_attributes)
        if db_order.changed?
          changes[order.orderID] = db_order.changes
          send_notification
          db_order.save
        end
      else # New order
        new_order = Order.new(order_attributes)
        new_order.save
      end
    end
    changes
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

  def self.send_notification
    
  end

end
