module MongoMapper
  module Plugins
    module Associations
      class ManyEmbeddedProxy < EmbeddedCollection
        def replace(values)
          @_values = values.map do |v|
            v.respond_to?(:attributes) ? v.attributes : v
          end
          reset
        end

        private
          def find_target
            (@_values || []).map do |v|
              child = klass.new(v)
              assign_root_document(child)
              child
            end
          end
      end
    end
  end
end
