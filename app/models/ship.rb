class Ship < ActiveRecord::Base
  attr_accessible :name, :ship_type

  has_many :runs
end
