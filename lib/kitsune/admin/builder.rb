module Kitsune
  class Admin
    class Builder
      def initialize(resource, &block)
        @resource = resource
        self.instance_eval &block
      end
      
      def self.generate(resource, &block)
        Builder.new(resource, &block)
      end
      
      
      def select(field, options)
        @resource.kitsune_admin[field] = {:type => :select, :options => options}
      end
    end
    
  end
end