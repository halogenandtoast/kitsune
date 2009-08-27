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
        @resource.kitsune_admin[:fields] ||= {}
        @resource.kitsune_admin[:fields][field] = {:type => :select, :options => options}
      end
      
      def display(*args)
        @resource.kitsune_admin[:display][:fields] ||= []
        args.each do |arg|
          unless arg.is_a?(Hash)
            @resource.kitsune_admin[:display][:fields] << arg
          else
            @resource.kitsune_admin[:display].merge!(arg)
          end
        end
      end
      
      def edit(*args)
        @resource.kitsune_admin[:edit][:fields] ||= []
        args.each do |arg|
          unless arg.is_a?(Hash)
            @resource.kitsune_admin[:edit][:fields] << arg
          else
            @resource.kitsune_admin[:edit].merge!(arg)
          end
        end
      end
    end
    
  end
end