require 'kitsune/config'
require 'kitsune/extensions/routes'

module Kitsune
  def self.models
    Dir.glob(File.join(RAILS_ROOT, 'app', 'models', '*.rb')).map do |file|
      file.split('/').last.split('.').first.classify
    end
  end
  
  def self.views(model)
    model_class = model.is_a?(String) ? model.underscore : model.class.to_s.underscore
    views = []
    Dir.glob(File.join(RAILS_ROOT, 'app', 'views', model_class.pluralize, '[^_]*')).map do |file|
      file.split('/').last.split('.').first
    end
  end
  
  def self.partials(model)
    model_class = model.is_a?(String) ? model.underscore : model.class.to_s.underscore
    partials = []
    Dir.glob(File.join(RAILS_ROOT, 'app', 'views', model_class.pluralize, '_*')).map do |file|
      file.split('/').last.split('.').first
    end
  end
end