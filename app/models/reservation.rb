class Reservation < ActiveRecord::Base
  attr_accessible :character_id, :run_id

  belongs_to :character
  belongs_to :run

  validates_uniqueness_of :run_id

  after_create :notify_admins

  def notify_admins
    message = NewReservationMessage.new
    message.title = "#{character.name} has reserved #{run.display_name}"
    message.save
    message.reservation_id = id
    Notification.send_to_admins(message)
  end
end
