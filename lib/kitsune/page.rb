module Kitsune
  module Page
    def self.included(model)
      model.class_eval do
        admin do
          display :title, :layout, :parent_id, :url
          wysiwyg :body
          select :layout, Proc.new {Dir.glob(File.join(RAILS_ROOT, 'app', 'views', 'layouts', '*.html.*')).map{|f| File.basename(f).split('.').first}}
        end
        
        before_save :update_url
        belongs_to :page, :foreign_key => "parent_id"
        belongs_to :parent, :class_name => 'Page'
        validate :must_be_kitsune_route
        validates_uniqueness_of :url
        
        def title_for_url
          CGI.escape(title.downcase.gsub(/\s+/, '-')).squeeze('-')
        end
        
        def url_for_page
          parent ? parent.url_for_page + '/' + title_for_url : '/' + title_for_url
        end
        
        def update_url
          write_attribute :url, (url.present? ? url : url_for_page)
        end
        
        def must_be_kitsune_route
          unless ActionController::Routing::Routes.recognize_path(url.present? ? url : url_for_page, :method => :get)[:controller] == 'kitsune'
            errors.add_to_base("URL is already being used")
          end
        end
      end
    end
  end
end