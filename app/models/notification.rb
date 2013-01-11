class Notification < ActiveRecord::Base
  attr_accessible :message_id, :read_at, :user_id

  belongs_to :user
  belongs_to :message
end
