class Admin::Kitsune::MediaController < Admin::Kitsune::KitsuneController
  layout 'admin/kitsune'
  
  helper 'admin/kitsune/records'
  
  before_filter :load_model
  
  def new
    @parent_instance = @parent.new_record
    @media = @model.new_record
    render :layout => false
  end
  
  def create
    @media = @model.new_record
    @upload = @model.new_record
    @parent_instance = @parent.new_record
    @upload.update_attribute(@parent.kitsune_admin[:media].values.first, params['image'])
    render 'new', :layout => false
  end
  
  private
  def load_model
    @parent = Kitsune::Inspector.new(params[:model_id].constantize) if params[:model_id]
    @model = Kitsune::Inspector.new(params[:id].constantize) if params[:id]
  end
end