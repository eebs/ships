class Reservation < ActiveRecord::Base
  attr_accessible :character_id, :run_id

  belongs_to :character
  belongs_to :run

  has_many :comments, :class_name => "ReservationComment"

  validates_uniqueness_of :run_id
end
