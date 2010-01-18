if defined?(ActionController::Routing::RouteSet)
  class ActionController::Routing::RouteSet
    def add_configuration_file_with_kitsune(file)
      lib_path = File.dirname(__FILE__)
      kitsune_routes = File.join(lib_path, *%w[.. .. .. config kitsune_routes.rb])
      if configuration_files.include?(kitsune_routes)
        self.configuration_files.delete(kitsune_routes)
      end
      add_configuration_file_without_kitsune(file)
      add_configuration_file_without_kitsune(kitsune_routes)
    end
    
    alias_method_chain :add_configuration_file, :kitsune
  end
end