if defined?(ActionController::Routing::RouteSet)
  class ActionController::Routing::RouteSet
    def load_routes_with_kitsune!
      lib_path = File.dirname(__FILE__)
      kitsune_routes = File.join(lib_path, *%w[.. .. .. config kitsune_routes.rb])
      unless configuration_files.include?(kitsune_routes)
        add_configuration_file(kitsune_routes)
      end
      load_routes_without_kitsune!
    end
    
    alias_method_chain :load_routes!, :kitsune
  end
end