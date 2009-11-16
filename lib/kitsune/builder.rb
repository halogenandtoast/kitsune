module Kitsune
  class TypeError < StandardError; end
  class Builder
    
    TYPES = [:check_box, :datetime_select, :password_field, :text_area, :text_field, :wysiwyg]
    def initialize(resource, &block)
      @resource = resource
      self.instance_eval &block
    end
    
    def category category
      @resource.kitsune_admin[:category] = category
    end
    
    def name name
      @resource.kitsune_admin[:name] = name
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
      add :file_field, field
      multipart
    end
    
    def image(field)
      add :file_field, field
      multipart
    end
    
    def multipart(value = true)
      @resource.kitsune_admin[:multipart] = value
    end
    
    def select(field, options)
      add :select, field, {:options => options}
    end
    
    def sti(field, options = {})
      add :sti, field, {:options => options}
      is_sti field
    end
    
    def is_sti(field)
      @resource.kitsune_admin[:is_sti] = true
      @resource.kitsune_admin[:sti_column] = field
    end
    
    def display_and_edit(*args)
      display *args
      edit *args
    end
    
    def display(*fields)
      set :display, fields
    end
    
    def edit(*fields)
      fields.each do |field|
        type = @resource.reflections[field.to_sym] ? :reflections : :edit
        set type, field
      end
    end
    
    def no_edit(*fields)
      set :no_edit, fields
    end
    
    def method_missing(method, *args, &block)
      if TYPES.include?(method)
        add method, *args
      end
    end
    
    private
    def add(type, field, options = {})
      @resource.kitsune_admin[:fields] ||= {}
      @resource.kitsune_admin[:fields][field] = options.merge(:type => type)
    end
    
    def set(type, fields)
      @resource.kitsune_admin[type] = {} unless @resource.kitsune_admin[type]
      @resource.kitsune_admin[type][:fields] ||= []
      [fields].flatten.each do |field|
        unless field.is_a?(Hash)
          @resource.kitsune_admin[type][:fields] << field
        else
          @resource.kitsune_admin[type].merge!(field)
        end
      end
    end
  end
end