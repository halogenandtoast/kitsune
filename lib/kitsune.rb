require 'kitsune/active_record'
require 'kitsune/extensions/routes'
require 'kitsune/form_helper_ext'

module Kitsune
  autoload :FauxColumn, 'kitsune/faux_column'
  autoload :Inspector, 'kitsune/inspector'
  autoload :Page, 'kitsune/page'
  class << self
    def version
      '0.0.1'
    end
  
    def model_paths # abstract this to something else
      ["#{RAILS_ROOT}/app/models"]
    end
    
    def models_with_admin
      models.select{|m| m.respond_to?(:kitsune_admin)} # quacks like a duck
    end
    
    def models
      models = []
      model_paths.each do |path|
        Dir.glob(path+'/*').each do |file|
          begin
            klass = File.basename(file).gsub(/^(.+).rb/, '\1').classify.constantize
            models << klass if klass.ancestors.include?(::ActiveRecord::Base)
          rescue Exception => e
            # not valid
          end
        end
      end
      models
    end
  end
end