module Admin::Kitsune::ModelsHelper
  def field_for(resource, column, value = nil)
    resource_name = ActionController::RecordIdentifier.singular_class_name(resource)
    field_name = "#{resource_name}[#{column.name}]"
    type = if resource.kitsune_admin && resource.kitsune_admin[column.name.to_sym]
      resource.kitsune_admin[column.name.to_sym][:type]
    else
      case column.type
      when :string, :integer then :text_field
      when :text then :text_area
      when :datetime then :datetime_select
      end
    end
    
    case type
      when :text_field then    text_field_tag field_name, value
      when :text_area then      text_area_tag field_name, value
      when :datetime_select then  datetime_select resource_name, column.name, :default => value
      when :select then           
        option_tags = nil
        if resource.kitsune_admin && resource.kitsune_admin[column.name.to_sym]
          options = resource.kitsune_admin[column.name.to_sym][:options]
          option_tags = options_from_collection_for_select(*options.call)
        end
        select_tag field_name, option_tags
        
      else "FOOK"
    end
  end
end