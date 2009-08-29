module Kitsune
  class Admin
    class Builder
      TYPES = [:text_field, :text_area, :check_box, :datetime_select, :password_field]
      def initialize(resource, &block)
        @resource = resource
        self.instance_eval &block
      end
      
      def self.generate(resource, &block)
        Builder.new(resource, &block)
      end
      
      def definitions
        yield # should be it's own builder
      end
      
      def columns
        @resource.columns
      end
      
      def sortable(*fields)
        @resource.kitsune_admin[:sortable] ||= []
        fields.each do |field|
          @resource.kitsune_admin[:sortable] << field.to_sym
        end
      end
      
      def select(field, options)
        add_definition(:select, field, {:options => options})
      end
      
      def display_and_edit(*args)
        display(*args)
        edit(*args)
      end
      
      def display(*fields)
        set_options_for_fields(:display, fields)
      end
      
      def edit(*fields)
        set_options_for_fields(:edit, fields)
      end
      
      def method_missing(method, *args, &block)
        if TYPES.include?(method)
          add_definition(method, *args)
        end
      end
      
      private
      def add_definition(type, field, options = {})
        @resource.kitsune_admin[:fields] ||= {}
        @resource.kitsune_admin[:fields][field] = options.merge(:type => type)
      end
      
      def set_options_for_fields(type, fields)
        @resource.kitsune_admin[type][:fields] ||= []
        fields.each do |field|
          unless field.is_a?(Hash)
            @resource.kitsune_admin[type][:fields] << field
          else
            @resource.kitsune_admin[type].merge!(field)
          end
        end
      end
    end
    
  end
end