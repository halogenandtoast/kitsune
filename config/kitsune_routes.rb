ActionController::Routing::Routes.draw do |map|
  map.connect '/admin/kitsune', :controller => 'admin/kitsune/models'
  map.namespace :admin do |admin|
    admin.namespace :kitsune do |kitsune|
      kitsune.resources :pages
      kitsune.resources :models do |model|
				model.resources :records
			end
    end
  end
  map.connect '/*url', :controller => 'kitsune', :action => 'show'
end
