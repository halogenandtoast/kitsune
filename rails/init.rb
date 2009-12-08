require 'kitsune'
require 'haml' # From gem
ActiveRecord::Base.extend(Kitsune::ActiveRecord)
Haml.init_rails(binding) if defined?(Haml)

