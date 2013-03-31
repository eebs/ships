class NewReservationMessage < Message
  include Redis::Objects

  value :reservation_id

  def reservation
    @reservation ||= Reservation.find_by_id(reservation_id.value)
  end

  def character
    reservation.character
  end

  def run
    reservation.run
  end

  def character_name
    character.name
  end

  def run_name
    run.display_name
  end
end
