class Message < ActiveRecord::Base
  attr_accessible :body, :title

  has_many :notifications
  has_many :characters, :through => :notifications
end
