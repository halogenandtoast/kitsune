class Admin::Kitsune::RecordsController < ApplicationController
  layout 'admin/kitsune'
  
  before_filter :load_model
  before_filter :load_record
  
  def index
    order, @sort_param, @sort_dir = nil, nil, nil
    if params[:sort]
      @sort_param = params[:sort]
      @sort_dir = params[:sort_dir]
      order = "#{params[:sort]} #{params[:sort_dir]}"
    end
    @records = @model.paginate(:page => params[:page], :order => order)
  end
  
  def new
    @record = @model.new_record
  end
  
  def create
    @record = @model.new_record(params[params[:model_id].underscore])
    if @record.save
      flash[:notice] = "Record Saved"
      redirect_to admin_kitsune_model_records_path(params[:model_id])
    else
      flash[:notice] = "Could not save record"
      render 'new'
    end
  end
  
  def update
    if @record.update_attributes(params[params[:model_id].underscore])
      flash[:notice] = "Record Saved"
      redirect_to admin_kitsune_model_records_path(params[:model_id])
    else
      flash[:notice] = "Could not save record"
      render 'edit'
    end
  end
  
  def destroy
    @record.destroy
    flash[:notice] = "Record Deleted"
    redirect_to admin_kitsune_model_records_path(params[:model_id])
  end
  
  private
  def load_model
    @model = Kitsune::Inspector.new(params[:model_id].constantize) if params[:model_id]
  end
  def load_record
    @record = @model.find(params[:id]) if params[:id]
  end
end