class NewReservationCommentMessage < Message
  value :reservation_id
  value :reservation_comment_id
  has_redis_object_relations

end
