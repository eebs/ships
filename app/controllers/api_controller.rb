class ApiController < ApplicationController
  before_filter :authenticate_character!
  before_filter :authenticate_admin!

  def orders
    @api = OrderApi.new
    @open_orders_hash = {}
    if open_orders = @api.open_orders
      open_orders.each do |order|
        entry = {}
        entry[:name] = @api.type_name(order.typeID)
        entry[:price] = order.price
        entry[:seller] = @api.char_name(order.charID)
        entry[:volRemaining] = order.volRemaining
        entry[:duration] = Time.zone.parse(order.issued) + order.duration.to_i.days
        @open_orders_hash[order.orderID] = entry
      end
    end

    @next_update = @api.next_update
  end
end
