module Admin::Kitsune::ModelsHelper
  
  def sort_link_to(resource, column)
    if resource.kitsune_admin[:sortable] && resource.kitsune_admin[:sortable].include?(column.name.to_sym)
      ascending = params[:sort] == column.name && params[:sort_dir] == 'DESC'
      options = {
        :model => @model.to_s,
        :sort => column.name, 
        :sort_dir => (ascending ? 'ASC' : 'DESC')
      }
      link_to column.name.titleize + (ascending ? ' &darr;' : ' &uarr;'), options
    else
      column.name.titleize
    end
  end
  
  def field_for(form, column, value = nil)
    resource = form.object
    resource_name = ActionController::RecordIdentifier.singular_class_name(resource)
    field_name = "#{resource_name}[#{column.name}]"
    type = if resource.kitsune_admin && resource.kitsune_admin[:fields] && resource.kitsune_admin[:fields][column.name.to_sym]
      resource.kitsune_admin[:fields][column.name.to_sym][:type]
    else
      case column.type
      when :string, :integer then :text_field
      when :text then :text_area
      when :datetime then :datetime_select
      when :boolean then :check_box
      end
    end
    
    case type
      when :text_field then    form.text_field column.name
      when :password_field then    form.password_field column.name
      when :text_area then      form.text_area column.name, :size => '50x4'
      when :datetime_select then  datetime_select resource_name, column.name, :default => value
      when :check_box then form.check_box column.name
      when :select then       
        options = nil
        if resource.kitsune_admin && resource.kitsune_admin[:fields] && resource.kitsune_admin[:fields][column.name.to_sym]
          collection_options = resource.kitsune_admin[:fields][column.name.to_sym][:options]
          collection_options = collection_options.call if collection_options.is_a?(Proc)
          collection, id, name = collection_options
          options = collection.map { |r| [ r.send(name), r.send(id) ] }
        end
        form.select column.name, options
        
      else "FOOK"
    end
  end
end