class RunValidator < ActiveModel::Validator
    def validate(record)
        # If id is nil, record is being created, not updated.
        if record.id.nil? && Run.find_by_ship_id_and_ship_number(record.ship_id, record.ship_number)
            record.errors[:base] << "Ship run already exists"
        end
    end
end