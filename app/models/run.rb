class Run < ActiveRecord::Base
  attr_accessible :next_due, :notes, :sell_date, :sell_price, :ship, :ship_number, :start_date, :status_id, :ship_id

  belongs_to :ship
  belongs_to :status
end
