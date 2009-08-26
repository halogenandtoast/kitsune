class Admin::Kitsune::PagesController < ApplicationController
  unloadable

  def index
    @pages = ::Page.all
    render :template => 'admin/pages/index'
  end
  
  def new
    @page = ::Page.new
    render :template => 'admin/pages/new'
  end
  
  def create
    @page = ::Page.new(params[:page])
    if @page.save
      redirect_to admin_pages_path
    else
      render :template => 'admin/pages/new'
    end
  end
end