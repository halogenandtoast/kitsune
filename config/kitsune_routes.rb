ActionController::Routing::Routes.draw do |map|
  map.admin '/admin', :controller => 'admin/kitsune/pages'
  
  map.connect '/admin/models', :controller => 'admin/kitsune/models'
  map.connect '/admin/models/:model/new', :controller => 'admin/kitsune/models', :action => 'new', :conditions => { :method => :get }
  map.connect '/admin/models/:model/:id/edit', :controller => 'admin/kitsune/models', :action => 'edit', :conditions => { :method => :get }
  map.connect '/admin/models/:model/:id', :controller => 'admin/kitsune/models', :action => 'destroy', :conditions => { :method => :delete }
  map.connect '/admin/models/:model/:id', :controller => 'admin/kitsune/models', :action => 'update', :conditions => { :method => :put }
  map.connect '/admin/models/:model', :controller => 'admin/kitsune/models', :action => 'show', :conditions => { :method => :get }
  map.connect '/admin/models/:model', :controller => 'admin/kitsune/models', :action => 'create', :conditions => { :method => :post }  
end
