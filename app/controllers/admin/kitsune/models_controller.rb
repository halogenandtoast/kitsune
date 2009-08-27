class Admin::Kitsune::ModelsController < ApplicationController
  unloadable
  layout 'admin/kitsune'
  
  def index
    @models = Kitsune.models
  end
  
  def show
    @model = params[:model].classify.constantize
    @records = @model.paginate(:page => params[:page])
    
    @columns = @model.columns
    if @model.kitsune_admin[:display][:fields]
      @columns = @columns.select {|column| @model.kitsune_admin[:display][:fields].include?(column.name.to_sym)}
    end
    
  end
  
  def new
    @model = params[:model].classify.constantize
    @columns = @model.columns
    if @model.kitsune_admin[:edit][:fields]
      @columns = @columns.select {|column| @model.kitsune_admin[:edit][:fields].include?(column.name.to_sym)}
    end
  end
  
  def edit
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
    @columns = @model.columns
    if @model.kitsune_admin[:edit][:fields]
      @columns = @columns.select {|column| @model.kitsune_admin[:edit][:fields].include?(column.name.to_sym)}
    end
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