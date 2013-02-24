class Ship < ActiveRecord::Base
  attr_accessible :name, :ship_type, :type_id, :finish_time

  has_many :runs

  validates :name,      :presence => true, :length => { :in => 2..20 }
  validates :ship_type, :presence => true, :length => { :in => 2..20 }
end
