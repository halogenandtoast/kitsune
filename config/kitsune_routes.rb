ActionController::Routing::Routes.draw do |map|
  map.connect '/admin/kitsune', :controller => 'admin/kitsune/models'
  map.namespace :admin do |admin|
    admin.namespace :kitsune do |kitsune|
      kitsune.resources :pages
      kitsune.resources :models, :has_many => [:records]
    end
  end
  
  map.connect '/*url', :controller => 'kitsune', :action => 'show'
end