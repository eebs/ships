class ReservationComment < ActiveRecord::Base
  attr_accessible :body, :character_id, :reservation_id

  belongs_to :character
  belongs_to :reservation
end
