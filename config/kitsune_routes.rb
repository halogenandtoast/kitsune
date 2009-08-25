ActionController::Routing::Routes.draw do |map|
  map.admin '/admin', :controller => 'admin/kitsune/pages'
  map.namespace :admin do |admin|
    admin.resources :pages, :controller => 'kitsune/pages'
  end
end
