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
    
    def media media
      @resource.kitsune_admin[:media] = media
    end
    
    def on_edit &block
      @resource.kitsune_admin[:on_edit] = block
    end
    
    def before_save &block
      @resource.kitsune_admin[:before_save] = block
    end
    
		def no_menu
			no_admin
		end
		
		def order_by(order)
		  order = {order => :asc} unless order.is_a?(Hash)
		  @resource.kitsune_admin[:order_by] = order
	  end
		
		def versioned
		  @resource.send(:versioned)
		  @resource.kitsune_admin[:versioned] = true
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

		def disable(*types)
			types.each do |type|
				@resource.kitsune_admin[:disabled] << type.to_sym
			end
		end
    
    def sortable(*fields)
      @resource.kitsune_admin[:sortable] ||= []
      fields.each do |field|
        @resource.kitsune_admin[:sortable] << field.to_sym
      end
    end
    
    def always(*fields)
      @resource.kitsune_admin[:always] ||= []
      fields.each do |field|
        @resource.kitsune_admin[:always] << field.to_sym
      end
    end
    
    def linked(*fields) # link to resource
      @resource.kitsune_admin[:linked] ||= []
      fields.each do |field|
        @resource.kitsune_admin[:linked] << field.to_sym
      end
    end
    
    def file(field)
      add :file_field, field
      multipart
    end
    
    def image(field)
      add :image_field, field
      multipart
    end
    
    def multipart(value = true)
      @resource.kitsune_admin[:multipart] = value
    end
    
    def select(field, options)
      add :select, field, {:options => options}
    end
    
    def string(field)
      add :text_field, field
    end
    
    def text(field)
      add :text_area, field
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
      fields.each do |field|
        if field.is_a?(Hash)
          field.each do |key, value|
            set :display, key
            set_attributes(key, value)
          end
        else
          set :display, field
        end
      end
    end
    
    def show(*fields)
      fields.each do |field|
        if field.is_a?(Hash)
          field.each do |key, value|
            set :show, key
            set_attributes(key, value)
          end
        else
          set :show, field
        end
      end
    end
    
    def set_attributes(field, attributes)
      [attributes].flatten.each do |attribute|
        send(attribute.to_sym, field)
      end
    end
    
    def edit(*fields)
      fields.each do |field|
        if field.is_a?(Hash)
          field.each do |key, value|
            type = @resource.reflections[key.to_sym] ? :reflections : :edit
            set(type, key)
            set_attributes(key, value)
          end
        else
          type = @resource.reflections[field.to_sym] ? :reflections : :edit
          set type, field
        end
      end
    end
    
    def no_edit(*fields)
      set :no_edit, fields
    end
    
    def method_missing(method, *args, &block)
      if TYPES.include?(method)
        add method, *args
      else
        raise Exception, "THIS IS WRONG@! #{method.to_s}"
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
