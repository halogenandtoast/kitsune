require 'kitsune'
require 'haml' # From gem
if defined? ::ActiveRecord
  ActiveRecord::Base.extend(Kitsune::ActiveRecord)
end
Haml.init_rails(binding) if defined?(Haml)

