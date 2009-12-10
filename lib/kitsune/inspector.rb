module Kitsune
  # Inspector is a proxy for adding additional methods. These should only be
  # available within the Kitsune admin.
  
  class Inspector
    attr_reader :object
    def initialize(object)
      @object = object
      @collection_label_methods = %w[to_label display_name full_name name title username login value to_s]
    end
    
    def admin_name
      kitsune_admin[:name] || @object.to_s.pluralize
    end
    
    def order_by
       order_by_hash ? order_by_hash.map{|k,v| "#{k} #{v}"}.join(' ') : nil
    end
    
    def order_by_hash
      kitsune_admin[:order_by] || nil
    end
    
    def category
      kitsune_admin[:category] || nil
    end
    
    def versioned?
      !!kitsune_admin[:versioned]
    end

		def disabled?(type)
			kitsune_admin[:disabled].include?(type.to_sym)
		end
    
    def is_sti?
      kitsune_admin[:is_sti]
    end
    
    def is_sti_child?
      if defined? ::ActiveRecord
        @object.ancestors[1] != ::ActiveRecord::Base
      else
        false
      end
    end
    
    def sti_column
      kitsune_admin[:sti_column]
    end
    
    def tabs
      kitsune_admin[:tabs]
    end
    
    def object_class
      @object.to_s
    end
    
    def new_record(*args)
      @object.new(*args)
    end
    
    def columns(type = nil, include_pk = false)
      unless type
        kolumns = @object.columns.dup
      else
        kolumns = send("columns_for_#{type}") if respond_to?("columns_for_#{type}")
      end
      include_pk ? kolumns : kolumns.reject{|c| c.primary }
    end
    
    def columns_for_edit
      kolumns = @object.columns.dup
      if kitsune_admin[:no_edit] && kitsune_admin[:no_edit][:fields]
        kolumns.reject{|c| kitsune_admin[:no_edit][:fields].include?(c.name.to_sym)}
      elsif kitsune_admin[:edit] && kitsune_admin[:edit][:fields]
        kolumns = kolumns.select{|c| kitsune_admin[:edit][:fields].include?(c.name.to_sym)}
        kolumn_names = kolumns.map{|c| c.name.to_sym}
        fields_to_add = kitsune_admin[:edit][:fields].reject{|f| kolumn_names.include?(f)}
        fields_to_add.each do |field|
          kolumns << Kitsune::FauxColumn.new(field, :string)
        end
        kolumns
      else
        kolumns
      end
    end
    
    def columns_for_display
      columns = @object.columns.dup
      if kitsune_admin[:display] && kitsune_admin[:display][:fields]
        columns = columns.select{|c| kitsune_admin[:display][:fields].include?(c.name.to_sym)}
        column_names = columns.map{|c| c.name.to_sym}
        fields_to_add = kitsune_admin[:display][:fields].reject{|f| column_names.include?(f)}
        fields_to_add.each do |field|
          columns << Kitsune::FauxColumn.new(field, :string)
        end
        columns
      else
        columns
      end
    end
    
    def columns_for_reflections
			if kitsune_admin[:reflections] && kitsune_admin[:reflections][:fields]
				kitsune_admin[:reflections][:fields].map do |field|
					Kitsune::FauxColumn.new(field, :string)
				end
			else
				[]
			end
    end
    
    def column_sortable(column)
      # move to column proxy
      kitsune_admin[:sortable] && kitsune_admin[:sortable].include?(column.name.to_sym)
    end
    
    def method_missing(method, *args, &block)
      @object.send(method, *args, &block)
    end
    
    def form_type(column)
      field = column.name
      if type = field_type(column.name)
        case type
        when :sti
          if (options = field_options(field)) && options[:classes]
            :select
          else
            :text_field
          end
				when :image_field
					:file_field
        else
          kitsune_admin[:fields][column.name.to_sym][:type]
        end
      elsif column.name =~ /._id$/
        :select
      else
        case column.type
          when :text then :text_area
          when :datetime then :datetime_select
          when :date then :date_select
          when :time then :time_select
          when :boolean then :check_box
          else :text_field
        end
      end
    end
    
    def detect_label(collection)
      @collection_label_methods.each do |label_name|
        return label_name if [collection].flatten.first.respond_to?(label_name)
      end
      'to_s'
    end
    
    def find_association_class(column)
      if @object.reflections[column.name.to_s.gsub(/_id$/,'').to_sym]
        if @object.reflections[column.name.to_s.gsub(/_id$/,'').to_sym].options && @object.reflections[column.name.to_s.gsub(/_id$/,'').to_sym].options[:class_name]
          @object.reflections[column.name.to_s.gsub(/_id$/,'').to_sym].options[:class_name].constantize
        else
          return column.name.to_s.gsub(/_id$/,'').classify.constantize
        end
      else
        # foreign key
        @object.reflections.each do |key, reflection|
          if reflection.options && reflection.options[:foreign_key] && reflection.options[:foreign_key] == column.name.to_s
            if reflection.options && reflection.options[:class_name]
              reflection.options[:class_name].constantize
            else
              return key.to_s.classify.constantize
            end
          end
        end
      end
    end
    
    def display_for(record, method, *args, &block)
      if method.to_s =~ /._id$/
        associated_record = record.send(method.to_s.gsub(/_id$/, '').to_sym, *args, &block)
        label_method = detect_label(associated_record)
        associated_record.send(label_method.to_sym)
      else
        record.send(method.to_sym, *args, &block)
      end
    end
    
    def form_options_for(record)
      options = {:method => method_for_record(record)}
      if kitsune_admin[:multipart]
        options.merge!({:html => {:multipart => true}})
      end
      options
    end
    
    def method_for_record(record)
      record.new_record? ? :post : :put
    end
    
    def options_for(column)
      
      field = column.name
      
      if field_type(field) == :select
        [field_options(field), {:include_blank => true}]
      elsif column.name =~ /._id$/
        id = :id
        collection = find_association_class(column).all
        name = detect_label(collection)
        [collection.map { |element| [ element.send(name), element.send(id) ] }, {:include_blank => true}]
      elsif field_type(field) == :sti && (options = field_options(field)) && options[:classes]
        [options[:classes].map {|element| [element.to_s, element.to_s]}, {:include_blank => true}]
      else
        options = field_options(field) || {}
        options[:size] = '80x10' if [:text_area, :wysiwyg].include?(form_type(column))
        [options]
      end
    end
    
    def field_type(field)
      return kitsune_admin[:fields][field.to_sym][:type] if field_defined(field)
      return nil
    end

    private
    def field_defined(field)
      !!kitsune_admin[:fields][field.to_sym]
    end
    
    def field_options(field)
      options = kitsune_admin[:fields][field.to_sym][:options] if field_defined(field)
      return (options.is_a?(Proc) ? options.call : options) if options
      return nil
    end
  end
end
