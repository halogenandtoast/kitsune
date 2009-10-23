class Admin::Kitsune::PagesController < ApplicationController
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
      redirect_to admin_kitsune_pages_path
    else
      render 'new'
    end
  end
  
  private
  def load_page
    @page = Page.find_by_url(params[:id]) if params[:id]
  end
end