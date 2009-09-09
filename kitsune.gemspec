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

date: 2009-09-09 00:00:00 -04:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: mislav-will_paginate
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ~>
      - !ruby/object:Gem::Version 
        version: 2.3.11
    version: 
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
- app/controllers/admin/kitsune/models_controller.rb
- app/controllers/admin/kitsune/pages_controller.rb
- app/helpers
- app/helpers/admin
- app/helpers/admin/kitsune
- app/helpers/admin/kitsune/models_helper.rb
- app/views
- app/views/admin
- app/views/admin/kitsune
- app/views/admin/kitsune/models
- app/views/admin/kitsune/models/_form.html.erb
- app/views/admin/kitsune/models/edit.html.erb
- app/views/admin/kitsune/models/index.html.erb
- app/views/admin/kitsune/models/new.html.erb
- app/views/admin/kitsune/models/show.html.erb
- app/views/admin/pages
- app/views/admin/pages/index.html.erb
- app/views/admin/pages/new.html.erb
- app/views/layouts
- app/views/layouts/admin
- app/views/layouts/admin/kitsune.html.erb
- config/kitsune_routes.rb
- generators/kitsune
- generators/kitsune/kitsune_generator.rb
- generators/kitsune/templates
- generators/kitsune/templates/migrations
- generators/kitsune/templates/migrations/create_pages.rb
- generators/kitsune/templates/page.rb
- generators/kitsune/USAGE
- lib/kitsune
- lib/kitsune/active_record.rb
- lib/kitsune/admin
- lib/kitsune/admin/builder.rb
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
requirements: 
- mislav-will_paginate
rubyforge_project: 
rubygems_version: 1.3.4
signing_key: 
specification_version: 3
summary: Integrated Rails Content Management System.
test_files: []

