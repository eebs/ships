class EveApi

    def api
        @api ||=  EAAL::API.new
    end

    def orders
        api.scope = 'corp'
        orders = api.MarketOrders.orders
        # Only fetch sell orders
        orders.reject! { |e| e.bid != '0' }
        orders
    end

    def open_orders
        api_orders = orders
        # Reject all orders that are not open
        api_orders.reject! { |e| e.orderState != '0' }
        api_orders
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

    def next_order_update
        api.scope = 'corp'
        Time.zone.parse(api.MarketOrders.cached_until)
    end

    def type_name(typeID)
        api.scope = 'eve'
        api.TypeName('ids' => typeID).types.first.typeName
    end

    def char_name(charID)
        api.scope = 'eve'
        api.CharacterName('ids' => charID).characters.first.name
    end
    
end