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
    states = {
      "0" => 'Open',
      "1" => 'Closed',
      "2" => 'Sold',
      "3" => 'Cancelled',
      "4" => 'Pending',
      "5" => 'Character Deleted',
    }
    states[orderState] || orderState
  end
end
