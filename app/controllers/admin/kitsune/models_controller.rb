class Admin::Kitsune::ModelsController < ApplicationController
  layout 'admin/kitsune'
  
  before_filter :load_model
  def index
    @models = Kitsune.models_with_admin
  end
  
  private
  def load_model
    @model = Kitsune::Inspector.new(params[:id].constantize) if params[:id]
  end
end