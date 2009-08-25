require 'rake'

gem_spec = Gem::Specification.new do |gem_spec|
  gem_spec.name = "kitsune"
  gem_spec.version = "0.0.1"
  gem_spec.summary = "Integrated Rails Content Management System."
  gem_spec.email = "matt@toastyapps.com"
  gem_spec.homepage = "http://github.com/toastyapps/kitsune"
  gem_spec.description = "Integrated Rails Content Management System."
  gem_spec.authors = ["Matthew Mongeau"]
  gem_spec.files = FileList["[A-Z]*", "{app,config,generators,lib,rails}/**/*"]
end

desc "Generate gemspec file"
task :gemspec do
  File.open("#{gem_spec.name}.gemspec", 'w') do |f|
    f.write gem_spec.to_yaml
  end
end