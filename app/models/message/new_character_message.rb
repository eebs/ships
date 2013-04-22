class NewCharacterMessage < Message
  value :character_id
  has_redis_object_relations
end
