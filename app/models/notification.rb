class Notification < ActiveRecord::Base
  attr_accessible :message_id, :read_at, :character_id

  belongs_to :character
  belongs_to :message

  def self.send_to_admins(message)
    if message.kind_of? Message
      users = Character.where(:admin => true)
      users.each do |user|
        user.notify(message)
      end
    end
  end
end
