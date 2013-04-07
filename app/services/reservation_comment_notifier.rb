class ReservationCommentNotifier
  
  def initialize(comment, current_character)
    @comment = comment
    @current_character = current_character
  end

  def send_notifications
    message = create_message
    notify_admins message
    notify_owner message
  end

private

  def notify_admins(message)
    Character.admins_except_current(@current_character).each do |character|
      character.notify(message)
    end
  end

  def notify_owner(message)
    reservation_character.notify(message) unless reservation_character == @current_character
  end

  def reservation_character
    @comment.reservation.character
  end

  def create_message
    message = NewReservationCommentMessage.create!(:title => "#{@current_character.name} commented on reservation for #{@comment.reservation.run.display_name}")
    message.reservation_id = @comment.reservation.id
    message.reservation_comment_id = @comment.id
    message
  end
end
