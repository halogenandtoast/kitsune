class KitsuneController < ApplicationController
  def show 
    @page = ::Page.find_by_url(params[:url].join('/'))
  end
end