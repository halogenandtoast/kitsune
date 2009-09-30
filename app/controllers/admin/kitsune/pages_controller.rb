class Admin::Kitsune::PagesController < ApplicationController
  unloadable

  def index
    @pages = ::Page.all
  end
  
  def new
    @page = ::Page.new
  end
  
  def show
    @page = ::Page.find_by_url(params[:url])
  end
  
  def create
    @page = ::Page.new(params[:page])
    if @page.save
      redirect_to admin_kitsune_pages_path
    else
      render 'new'
    end
  end
end