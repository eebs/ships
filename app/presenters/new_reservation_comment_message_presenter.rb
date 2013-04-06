class NewReservationCommentMessagePresenter < BasePresenter
  presents :message

  def header
    begin
      character_name + ' commented on ' + reservation_link
    rescue ActiveRecord::RecordNotFound => e
      "Reservation has been deleted"
    end
  end

  def comment
    
  end

private

  def character_name
    if current_character.admin?
      link_to(commenter.name, commenter)
    else
      commenter.name.html_safe
    end
  end

  def reservation_link
    link_to(reservation_name, reservation_path_with_anchor)
  end

  def reservation_path_with_anchor
    reservation_path(message.reservation, :anchor => "reservation-comment-#{message.reservation_comment.id}")
  end

  def commenter
    message.reservation_comment.character
  end

  def reservation_name
    message.reservation.run.display_name
  end
end
