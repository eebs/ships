class NewReservationMessage < Message
  value :reservation_id
  has_redis_object_relations

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
