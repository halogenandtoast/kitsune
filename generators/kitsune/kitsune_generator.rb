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
    end
  end
end