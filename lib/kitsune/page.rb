module Kitsune
  module Page
    def self.included(model)
      model.class_eval do
        admin do
          wysiwyg :body
        end
        
        before_save :update_url
        belongs_to :page, :foreign_key => "parent_id"
        
        def update_url
          write_attribute :url, title
        end
      end
    end
  end
end