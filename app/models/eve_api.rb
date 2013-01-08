class EveApi

    def api
        @api ||=  EAAL::API.new
    end

    def open_orders
        api.scope = 'corp'
        orders = api.MarketOrders.orders
        # Reject all orders that are not open
        orders.reject! { |e| e.orderState != '0' }
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