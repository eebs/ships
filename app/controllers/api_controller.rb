class ApiController < ApplicationController

  def initialize
    super
    @api = EveApi.new
  end

  def orders
    orders = @api.open_orders

    @open_orders = {}

    orders.each do |order|
      entry = {}
      entry[:name] = @api.type_name(order.typeID)
      entry[:price] = order.price
      entry[:seller] = @api.char_name(order.charID)
      entry[:volRemaining] = order.volRemaining
      entry[:duration] = Time.zone.parse(order.issued) + order.duration.to_i.days
      @open_orders[order.typeID] = entry
    end

    @next_update = @api.next_order_update
  end
end
