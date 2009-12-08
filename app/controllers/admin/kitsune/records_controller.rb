class Admin::Kitsune::RecordsController < Admin::Kitsune::KitsuneController
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
    if @model.is_sti? && params[params[:model_id].underscore][@model.sti_column].present?
      sti_model = Kitsune::Inspector.new(params[params[:model_id].underscore].delete(@model.sti_column).constantize)
      @record = sti_model.new_record(params[params[:model_id].underscore])
    else
      @record = @model.new_record(params[params[:model_id].underscore])
    end
    if @record.save
      flash[:notice] = "Record Saved"
			if params[:redirect]
				klass = params[:redirect].gsub(/_id$/, '').classify.constantize
				record = klass.find(params[:redirect_id])
				redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => klass.to_s, :id => params[:redirect_id], :action => :edit)
			else
				redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => @model.class_name)
			end
    else
      flash[:notice] = "Could not save record"
      render 'new'
    end
  end
  
  def update
    
    if @model.is_sti_child? && params[params[:model_id].underscore][:type]
      if params[params[:model_id].underscore][:type].to_s != @record.type.to_s
        @record.type = params[params[:model_id].underscore][:type]
        @record.save
      end
    end
    
    if @record.update_attributes(params[params[:model_id].underscore])
      flash[:notice] = "Record Saved"
			if params[:redirect]
				klass = params[:redirect].gsub(/_id$/, '').classify.constantize
				record = klass.find(params[:redirect_id])
				redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => klass.to_s, :id => params[:redirect_id], :action => :edit)
			else
				redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => @model.class_name)
			end
    else
      flash[:notice] = "Could not save record"
      render 'edit'
    end
  end
  
  def destroy
    @record.destroy
    flash[:notice] = "Record Deleted"
		if params[:redirect]
			klass = params[:redirect].gsub(/_id$/, '').classify.constantize
			record = klass.find(params[:redirect_id])
			redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => klass.to_s, :id => params[:redirect_id], :action => :edit)
		else
			redirect_to url_for(:controller => 'admin/kitsune/records', :model_id => @model.class_name)
		end
  end
  
  private
  def load_model
    @model = Kitsune::Inspector.new(params[:model_id].constantize) if params[:model_id]
  end
  def load_record
    @record = @model.find(params[:id]) if params[:id]
    @record.revert_to(params[:version].to_i) if params[:version]
  end
end
