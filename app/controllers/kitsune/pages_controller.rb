class Kitsune::PagesController < ApplicationController
  unloadable
  
  def show
    @page = ::Page.find_by_url(params[:url])
    render :text => @page.inspect and return
  end
  
end