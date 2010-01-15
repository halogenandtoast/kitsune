class KitsuneController < ApplicationController
  def show 
    @page = ::Page.find_by_url('/'+[params[:url]].flatten.join('/'))
    raise ::ActionController::RoutingError, "No route matches #{request.path.inspect}" unless @page.present?
		@title = @page.title
  end
end
