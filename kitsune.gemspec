--- !ruby/object:Gem::Specification 
name: kitsune
version: !ruby/object:Gem::Version 
  version: 0.0.16
platform: ruby
authors: 
- Matthew Mongeau <matt@toastyapps.com>
autorequire: 
bindir: bin
cert_chain: []

date: 2009-12-08 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: will_paginate
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ~>
      - !ruby/object:Gem::Version 
        version: 2.3.11
    version: 
- !ruby/object:Gem::Dependency 
  name: haml
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ~>
      - !ruby/object:Gem::Version 
        version: 2.2.12
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
- app/controllers/admin/kitsune/application_controller.rb
- app/controllers/admin/kitsune/kitsune_controller.rb
- app/controllers/admin/kitsune/models_controller.rb
- app/controllers/admin/kitsune/pages_controller.rb
- app/controllers/admin/kitsune/records_controller.rb
- app/controllers/kitsune_controller.rb
- app/helpers
- app/helpers/admin
- app/helpers/admin/kitsune
- app/helpers/admin/kitsune/records_helper.rb
- app/views
- app/views/admin
- app/views/admin/kitsune
- app/views/admin/kitsune/models
- app/views/admin/kitsune/models/index.html.haml
- app/views/admin/kitsune/pages
- app/views/admin/kitsune/pages/_form.html.erb
- app/views/admin/kitsune/pages/edit.html.erb
- app/views/admin/kitsune/pages/index.html.erb
- app/views/admin/kitsune/pages/new.html.erb
- app/views/admin/kitsune/records
- app/views/admin/kitsune/records/_form.html.haml
- app/views/admin/kitsune/records/_list.html.haml
- app/views/admin/kitsune/records/edit.html.haml
- app/views/admin/kitsune/records/index.html.haml
- app/views/admin/kitsune/records/new.html.haml
- app/views/kitsune
- app/views/kitsune/show.html.erb
- app/views/layouts
- app/views/layouts/admin
- app/views/layouts/admin/kitsune.html.erb
- config/kitsune_routes.rb
- generators/kitsune
- generators/kitsune/kitsune_generator.rb
- generators/kitsune/lib
- generators/kitsune/lib/insert_commands.rb
- generators/kitsune/templates
- generators/kitsune/templates/images
- generators/kitsune/templates/images/back-arrow.gif
- generators/kitsune/templates/images/bg.jpg
- generators/kitsune/templates/images/box-shadow.png
- generators/kitsune/templates/images/content-bg.gif
- generators/kitsune/templates/images/form-bg.gif
- generators/kitsune/templates/images/grey-btn.png
- generators/kitsune/templates/images/header-bg.gif
- generators/kitsune/templates/images/header-link.png
- generators/kitsune/templates/images/nicEditorIcons.gif
- generators/kitsune/templates/javascripts
- generators/kitsune/templates/javascripts/jquery.js
- generators/kitsune/templates/javascripts/kitsune_jquery.js
- generators/kitsune/templates/javascripts/nicEdit.js
- generators/kitsune/templates/migrations
- generators/kitsune/templates/migrations/create_pages.rb
- generators/kitsune/templates/page.rb
- generators/kitsune/templates/README
- generators/kitsune/templates/stylesheets
- generators/kitsune/templates/stylesheets/global.css
- generators/kitsune/templates/stylesheets/ie.css
- generators/kitsune/templates/VERSIONED_README
- generators/kitsune/USAGE
- generators/kitsune_flat_files
- generators/kitsune_flat_files/kitsune_flat_files_generator.rb
- generators/kitsune_flat_files/templates
- generators/kitsune_flat_files/templates/index.html.erb
- generators/kitsune_flat_files/templates/views
- generators/kitsune_flat_files/templates/views/erb
- generators/kitsune_flat_files/templates/views/erb/admin
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/models
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/models/_form.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/models/index.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/pages
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/pages/_form.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/pages/edit.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/pages/index.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/pages/new.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records/_form.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records/_list.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records/edit.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records/index.html.erb
- generators/kitsune_flat_files/templates/views/erb/admin/kitsune/records/new.html.erb
- generators/kitsune_flat_files/templates/views/erb/kitsune
- generators/kitsune_flat_files/templates/views/erb/kitsune/show.html.erb
- generators/kitsune_flat_files/templates/views/erb/layouts
- generators/kitsune_flat_files/templates/views/erb/layouts/admin
- generators/kitsune_flat_files/templates/views/erb/layouts/admin/kitsune.html.erb
- lib/kitsune
- lib/kitsune/active_record.rb
- lib/kitsune/builder.rb
- lib/kitsune/extensions
- lib/kitsune/extensions/routes.rb
- lib/kitsune/faux_column.rb
- lib/kitsune/form_helper_ext.rb
- lib/kitsune/inspector.rb
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
- will_paginate
- haml
rubyforge_project: 
rubygems_version: 1.3.5
signing_key: 
specification_version: 3
summary: Integrated Rails Content Management System.
test_files: []

