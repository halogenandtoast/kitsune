class KitsuneController < ApplicationController
  def show 
    @page = ::Page.find_by_url([params[:url]].flatten.join('/'))
  end
end