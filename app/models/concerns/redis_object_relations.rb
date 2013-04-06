module RedisObjectRelations
  extend ActiveSupport::Concern

  module ClassMethods
    # If a message has a redis object in the form <name>_id
    # define a method <name> that loads the appropriate
    # Active Record object from the database.
    def has_redis_object_relations
      redis_objects.each do |object, options|
        if m = /^(?<name>.*)_id$/.match(object)
          name = m[:name]
          class_eval <<-EndMethods
            def #{name}
              @#{name} ||= #{name.camelize}.find(#{name}_id.value)
            end
          EndMethods
        end
      end
    end
  end
  
end
