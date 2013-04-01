class Order < ActiveRecord::Base
  attr_accessible :bid, :charID, :duration, :minVolume, :orderID, :orderState, :price, :range, :stationID, :typeID, :volEntered, :volRemaining

  scope :open, where(:orderState => '0')

  def item_title
    api = OrderApi.new
    api.type_name(typeID)
  end

  def seller_name
    api = OrderApi.new
    api.char_name(charID)
  end

  def status
    self.class.status(orderState) || orderState
  end

  def self.status(state)
    states = {
      "0" => 'Open',
      "1" => 'Closed',
      "2" => 'Sold',
      "3" => 'Cancelled',
      "4" => 'Pending',
      "5" => 'Character Deleted',
    }
    states[state] || state
  end

  def self.field_name(field)
    names = {
      'orderState' => 'Status',
      'volRemaining' => 'Volume Remaining',
    }
    names[field] || field.capitalize
  end
end
