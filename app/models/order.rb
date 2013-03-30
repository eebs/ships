class Order < ActiveRecord::Base
  attr_accessible :bid, :charID, :duration, :minVolume, :orderID, :orderState, :price, :range, :stationID, :typeID, :volEntered, :volRemaining

  scope :open, where(:orderState => '0')

  def item_title
    api = OrderApi.new
    api.type_name(typeID)
  end
end
