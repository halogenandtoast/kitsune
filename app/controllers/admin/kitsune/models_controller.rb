class Admin::Kitsune::ModelsController < ApplicationController
  unloadable
  layout 'admin/kitsune'
  
  def index
    @models = Kitsune.models
  end
  
  def show
    order, @sort_param, @sort_dir = nil, nil, nil
    if params[:sort]
      @sort_param = params[:sort]
      @sort_dir = params[:sort_dir]
      order = "#{params[:sort]} #{params[:sort_dir]}"
    end
    @model = params[:model].classify.constantize
    @records = @model.paginate(:page => params[:page], :per_page => 10, :order => order)
    populate_columns(:display)    
  end
  
  def new
    @model = params[:model].classify.constantize
    @resource = @model.new
    @reflections = @model.reflections
    populate_columns(:edit)
  end
  
  def edit
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
    @reflections = @model.reflections
    populate_columns(:edit)
  end
  
  def create
    @model = params[:model].classify.constantize
    @resource = @model.new(params[@model.to_s.downcase])
    if @resource.save
      redirect_to(url_for(:action => 'show', :model => @model.to_s))
    else
      @reflections = @model.reflections
      populate_columns(:edit)
      render 'edit'
    end
  end
  
  def update
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
    if @resource.update_attributes(params[@model.to_s.downcase])
      redirect_to(url_for(:action => 'show', :model => @model.to_s))
    else
      @reflections = @model.reflections
      populate_columns(:edit)
      render 'new'
    end
  end
  
  def destroy
    @model = params[:model].classify.constantize
    @resource = @model.find(params[:id])
    @resource.destroy
    redirect_to(url_for(:action => 'show', :model => @model.to_s))
  end
  
  private
  def populate_columns(type)
    @columns = @model.columns
    if @model.kitsune_admin && @model.kitsune_admin[type] && @model.kitsune_admin[type][:fields]
      @columns = @columns.select {|column| @model.kitsune_admin[type][:fields].include?(column.name.to_sym)}
      column_names = @columns.map(&:name)
      @model.kitsune_admin[type][:fields].each do |field|
        @columns << Kitsune::FauxColumn.new(field.to_sym, :string) unless column_names.include?(field.to_s)
      end
    end
  end
end