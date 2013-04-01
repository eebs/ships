class NewOrderMessage < Message
  value :order_id
  has_redis_object_relations
end
