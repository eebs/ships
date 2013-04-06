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
    div_for message.reservation_comment do
      simple_format(truncate message.reservation_comment.body, :length => 300, :separator => ' ', :omission => comment_omission)
    end
  end

private

  def comment_omission
    '... ' + reservation_link('Read more')
  end

  def character_name
    if current_character.admin?
      link_to(commenter.name, commenter)
    else
      commenter.name.html_safe
    end
  end

  def reservation_link(text = nil)
    text ||= reservation_name
    link_to(text, reservation_path_with_anchor)
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
