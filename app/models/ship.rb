class Ship < ActiveRecord::Base
  attr_accessible :name, :ship_type

  has_many :runs

  validates :name,      :presence => true, :length => { :in => 2..20 }
  validates :ship_type, :presence => true, :length => { :in => 2..20 }
end
