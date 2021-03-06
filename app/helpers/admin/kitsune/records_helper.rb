module Admin::Kitsune::RecordsHelper
  def url_for_record(record)
    record.new_record? ? admin_kitsune_model_records_path(record.class.to_s) : admin_kitsune_model_record_path(record.class.to_s, record.id)
  end
  
  def sort_link_to(resource, column)
    if resource.column_sortable(column)
      ascending = false
      unless params[:sort]
        if resource.order_by_hash && resource.order_by_hash.keys.include?(column.name.to_sym)
          params[:sort] = column.name
          params[:sort_dir] = resource.order_by_hash[column.name.to_sym].to_s.upcase
        end
      end
      ascending = params[:sort] == column.name && params[:sort_dir] == 'DESC'
      options = {
        :model => resource.object,
        :sort => column.name, 
        :sort_dir => (ascending ? 'ASC' : 'DESC')
      }
      link_to column.name.to_s.titleize + (ascending ? ' &darr;' : (params[:sort] == column.name ? ' &uarr;' : ' &#8597;')), options
    else
      column.name.to_s.titleize
    end
  end

	def additional_content_for(model, record, column)
		if model.field_type(column.name) == :file_field && (file = record.send(column.name)).present?
			"<p><strong>Current File</strong>: " + link_to(file.to_s, file.to_s) + "</p>"
		elsif model.field_type(column.name) == :image_field && (file = record.send(column.name)).present?
			"<p><strong>Current File</strong>: " + image_tag(file.to_s) + "</p>"
		end
	end
	
	def kitsune_title
	  " - #{@model.admin_name}" + " : #{params[:action].titleize}"
	end
	
end
