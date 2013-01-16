class ApiController < ApplicationController
  before_filter :authenticate_user!

  def orders
    @api = EveApi.new
    @open_orders_hash = {}
    if open_orders = @api.open_orders
      open_orders.each do |order|
        entry = {}
        entry[:name] = @api.type_name(order.typeID)
        entry[:price] = order.price
        entry[:seller] = @api.char_name(order.charID)
        entry[:volRemaining] = order.volRemaining
        entry[:duration] = Time.zone.parse(order.issued) + order.duration.to_i.days
        @open_orders_hash[order.typeID] = entry
      end
    end

    @next_update = @api.next_order_update
  end
end
