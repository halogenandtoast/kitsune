module Admin::Kitsune::RecordsHelper
  def url_for_record(record)
    record.new_record? ? admin_kitsune_model_records_path(record.class.to_s) : admin_kitsune_model_record_path(record.class.to_s, record.id)
  end
  
  def sort_link_to(resource, column)
    if resource.column_sortable(column)
      ascending = params[:sort] == column.name && params[:sort_dir] == 'DESC'
      options = {
        :model => resource.object,
        :sort => column.name, 
        :sort_dir => (ascending ? 'ASC' : 'DESC')
      }
      link_to column.name.to_s.titleize + (ascending ? ' &darr;' : ' &uarr;'), options
    else
      column.name.to_s.titleize
    end
  end
end