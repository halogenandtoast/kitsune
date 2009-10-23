module Kitsune
  class TypeError < StandardError; end
  class Builder
    
    TYPES = [:check_box, :datetime_select, :password_field, :text_area, :text_field, :wysiwyg]
    def initialize(resource, &block)
      @resource = resource
      self.instance_eval &block
    end
    
    def no_admin
      @resource.kitsune_admin[:no_admin] = true
    end
    
    def tabs(tabs)
      @resource.kitsune_admin[:tabs] = tabs
    end
    
    def self.generate(resource, &block)
      Builder.new(resource, &block)
    end
    
    def definitions
      yield # should be it's own builder
    end
    
    def columns(type = nil)
      @resource.columns
    end
    
    def sortable(*fields)
      @resource.kitsune_admin[:sortable] ||= []
      fields.each do |field|
        @resource.kitsune_admin[:sortable] << field.to_sym
      end
    end
    
    def file(field)
      add_definition(:file_field, field)
      multipart
    end
    
    def multipart(value = true)
      @resource.kitsune_admin[:multipart] = value
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
    
    def no_edit(*fields)
      set_options_for_fields(:no_edit, fields)
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
      @resource.kitsune_admin[type] = {} unless @resource.kitsune_admin[type]
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