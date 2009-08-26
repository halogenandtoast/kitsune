module Admin::Kitsune::ModelsHelper
  def field_for(resource, column, value = nil)
    resource_name = ActionController::RecordIdentifier.singular_class_name(resource)
    field_name = "#{resource_name}[#{column.name}]"
    case column.type.to_s
      when 'string' then    text_field_tag field_name, value
      when 'text' then      text_area_tag field_name, value
      when 'datetime' then  datetime_select resource_name, column.name, :default => value
      else "FOOK"
    end
  end
end