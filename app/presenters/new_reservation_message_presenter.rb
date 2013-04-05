class NewReservationMessagePresenter < BasePresenter
  presents :message

  def body
    begin
      link_to(message.character_name, message.character) + ' has reserved ' + link_to(message.run_name, message.run)
    rescue ActiveRecord::RecordNotFound => e
      "Reservation has been deleted"
    end
  end
end
