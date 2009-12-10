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
      
      if !!@include_users
        m.migration_template "migrations/create_kitsune_users.rb", 'db/migrate', :migration_file_name => "kitsune_create_kitsune_users"
      end
      
      if !!@versioned
        Rails::Generator::Scripts::Generate.new.run(['vestal_versions_migration'])
      end
      
                  
      m.directory "public/javascripts/kitsune/"
      %w[jquery.js kitsune_jquery.js upload_maker.js].each do |js|
        m.file "javascripts/#{js}", "public/javascripts/kitsune/#{js}"
      end
      
      tiny_mce_path = "public/javascripts/kitsune/tiny_mce"
      m.directory tiny_mce_path
      
      Dir.glob(File.dirname(__FILE__)+"/templates/javascripts/tiny_mce/**/*").each do |file|
        short_path = file.gsub(/#{File.dirname(__FILE__)}\/templates\/javascripts\/tiny_mce\//, '')
        if File.directory?(file)
          m.directory "public/javascripts/kitsune/tiny_mce/#{short_path}"
        else
          m.file "javascripts/tiny_mce/#{short_path}", "#{tiny_mce_path}/#{short_path}"
        end
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
