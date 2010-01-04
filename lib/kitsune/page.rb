module Kitsune
  module Page
    def self.included(model)
      model.class_eval do
        admin do
          wysiwyg :body
          select :layout, Proc.new {Dir.glob(File.join(RAILS_ROOT, 'app', 'views', 'layouts', '*.html.haml')).map{|f| File.basename(f).split('.').first}}
        end
        
        before_save :update_url
        belongs_to :page, :foreign_key => "parent_id"
        belongs_to :parent, :class_name => 'Page'
        
        def update_url
          unless url.present?
            write_attribute :url, CGI.escape(title.downcase.gsub(/\s+/, '-')) 
          else
            write_attribute :url, CGI.escape(url)
          end
        end
      end
    end
  end
end