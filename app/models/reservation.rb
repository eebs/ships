class Reservation < ActiveRecord::Base
  attr_accessible :character_id, :run_id

  belongs_to :character
  belongs_to :run

  validates_uniqueness_of :run_id

  after_create :notify_admins

  def notify_admins
    message = Message.new
    message.title = "New Reservation"
    message.body = "#{character.name} has reserved #{run.display_name}"
    Notification.send_to_admins(message) if message.save
  end
end
