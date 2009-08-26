--- !ruby/object:Gem::Specification 
name: kitsune
version: !ruby/object:Gem::Version 
  version: 0.0.1
platform: ruby
authors: 
- Matthew Mongeau <matt@toastyapps.com>
- Tom Scott <tubbo@psychedeli.ca>
autorequire: 
bindir: bin
cert_chain: []

date: 2009-08-25 00:00:00 -04:00
default_executable: 
dependencies: []

description: Integrated Rails Content Management System.
email: matt@toastyapps.com
executables: []

extensions: []

extra_rdoc_files: []

files: 
- Rakefile
- README.textile
- app/controllers
- app/controllers/admin
- app/controllers/admin/kitsune
- app/controllers/admin/kitsune/pages_controller.rb
- app/views
- app/views/admin
- app/views/admin/pages
- app/views/admin/pages/index.html.erb
- app/views/admin/pages/new.html.erb
- config/kitsune_routes.rb
- generators/kitsune
- generators/kitsune/kitsune_generator.rb
- generators/kitsune/templates
- generators/kitsune/templates/migrations
- generators/kitsune/templates/migrations/create_pages.rb
- generators/kitsune/templates/page.rb
- generators/kitsune/USAGE
- lib/kitsune
- lib/kitsune/config.rb
- lib/kitsune/extensions
- lib/kitsune/extensions/routes.rb
- lib/kitsune/page.rb
- lib/kitsune.rb
- rails/init.rb
has_rdoc: true
homepage: http://github.com/toastyapps/kitsune
licenses: []

post_install_message: 
rdoc_options: []

require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
requirements: []

rubyforge_project: 
rubygems_version: 1.3.5
signing_key: 
specification_version: 3
summary: Integrated Rails Content Management System.
test_files: []

