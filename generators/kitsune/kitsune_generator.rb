require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class KitsuneGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      page_model = "app/models/page.rb"
                  if File.exists?(page_model)
                    m.insert_into page_model, "include Kitsune::Page"
                  else
                    m.directory File.join("app", "models")
                    m.file "page.rb", page_model
                  end
            
            m.migration_template "migrations/create_pages.rb",
                                        'db/migrate',
                                        :migration_file_name => "kitsune_create_pages"
      m.directory "public/stylesheets/kitsune/"
      m.file "stylesheets/global.css", "public/stylesheets/kitsune/global.css"
      m.directory "public/images/kitsune/"
      %w[bg.jpg form-bg.gif grey-btn.png].each do |image|
        m.file "images/#{image}", "public/images/kitsune/#{image}"
      end
      
      
    end
  end
end