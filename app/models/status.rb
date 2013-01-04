class Status < ActiveRecord::Base
  attr_accessible :color, :name

  has_many :runs
end
