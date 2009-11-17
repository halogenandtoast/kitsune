class Admin::Kitsune::PagesController < Admin::Kitsune::KitsuneController
  layout 'admin/kitsune'
  
  before_filter :load_page
  
  def index
    @pages = ::Page.all
  end
  
  def new
    @page = ::Page.new
  end
  
  def create
    @page = ::Page.new(params[:page])
    if @page.save
      redirect_to url_for(:controller => 'admin/kitsune/pages')
    else
      render 'new'
    end
  end
  
  def update
    if @page.update_attributes(params[:page])
      redirect_to url_for(:controller => 'admin/kitsune/pages')
    else
      render 'edit'
    end
  end
  
  private
  def load_page
    @page = Page.find_by_url(params[:id]) if params[:id]
  end
end