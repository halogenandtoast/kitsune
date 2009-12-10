require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class KitsuneGenerator < Rails::Generator::Base
  
  def initialize(runtime_args, runtime_options = {})
    @versioned = runtime_args.delete("--versioned")
    @include_pages = runtime_args.delete("--include-page-model")
    @include_users = runtime_args.delete("--include-user-model")
    super
  end
  
  def manifest
    record do |m|
      if !!@include_pages
        page_model = "app/models/page.rb"
        if File.exists?(page_model)
          m.insert_into page_model, "include Kitsune::Page"
        else
          m.directory File.join("app", "models")
          m.file "page.rb", page_model
          m.migration_template "migrations/create_pages.rb", 'db/migrate', :migration_file_name => "kitsune_create_pages"
        end
      end
      
      if !!@versioned
        Rails::Generator::Scripts::Generate.new.run(['vestal_versions_migration'])
      end
      
                  
      m.directory "public/javascripts/kitsune/"
      %w[nicEdit.js jquery.js kitsune_jquery.js upload_maker.js].each do |js|
        m.file "javascripts/#{js}", "public/javascripts/kitsune/#{js}"
      end
      m.directory "public/stylesheets/kitsune/"
      m.file "stylesheets/global.css", "public/stylesheets/kitsune/global.css"
      m.file "stylesheets/ie.css", "public/stylesheets/kitsune/ie.css"
      m.directory "public/images/kitsune/"
      %w[back-arrow.gif box-shadow.png content-bg.gif header-bg.gif form-bg.gif header-link.png grey-btn.png nicEditorIcons.gif].each do |image|
        m.file "images/#{image}", "public/images/kitsune/#{image}"
      end
      
      if !!@versioned
        m.readme "VERSIONED_README"
      else
        m.readme "README"
      end
            
    end
  end
end
