class EveApi

    def api
        @api ||=  EAAL::API.new
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
