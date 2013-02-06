class Reservation < ActiveRecord::Base
  attr_accessible :character_id, :run_id

  belongs_to :character
  belongs_to :run

  validates_uniqueness_of :run_id
end
