ActionController::Routing::Routes.draw do |map|
  map.connect '/admin/kitsune', :controller => 'admin/kitsune/models'
  map.namespace :admin do |admin|
    admin.namespace :kitsune do |kitsune|
      kitsune.resource :session
      kitsune.resources :kitsune_users, :as => :users
      kitsune.resources :pages
      kitsune.resources :models do |model|
				model.resources :records
        model.resources :media, :only => [:new, :create]
			end
    end
  end
  
  if defined?(Page)
    Page.all.each do |page|
      map.connect page.url, :controller => 'kitsune', :action => 'show', :url => page.url[1..-1].split('/')
    end
  end
  
end
