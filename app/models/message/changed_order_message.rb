class ChangedOrderMessage < Message
  value :order_id
  value :changes, :marshal => true
  has_redis_object_relations
end
