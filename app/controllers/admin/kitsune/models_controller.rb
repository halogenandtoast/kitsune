class Admin::Kitsune::ModelsController < Admin::Kitsune::KitsuneController
  layout 'admin/kitsune'
  
  before_filter :load_model
  
  private
  def load_model
    @model = Kitsune::Inspector.new(params[:id].constantize) if params[:id]
  end
end