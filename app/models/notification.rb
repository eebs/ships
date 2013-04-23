class Notification < ActiveRecord::Base
  attr_accessible :message_id, :read_at, :character_id

  belongs_to :character
  belongs_to :message
end
