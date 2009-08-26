class Admin::Kitsune::ModelsController < ApplicationController
  unloadable
  
  def index
    @models = Kitsune.models
  end
  
  def show
    @model = params[:model].classify.constantize
    @records = @model.paginate(:page => params[:page])
  end
  
  def new
    @model = params[:model].classify.constantize
  end
  
  def edit
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
  end
  
  def create
    @model = params[:model].classify.constantize
    @resource = @model.new(params[@model.to_s.downcase])
    if @resource.save
      redirect_to(url_for(:action => 'show', :model => @model.to_s))
    else
      render 'new'
    end
  end
  
  def destroy
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
    @resource.destroy
    redirect_to(url_for(:action => 'show', :model => @model.to_s))
  end
end