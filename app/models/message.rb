class Message < ActiveRecord::Base
  include Redis::Objects
  include RedisObjectRelations

  attr_accessible :body, :title

  has_many :notifications
  has_many :characters, :through => :notifications
end
