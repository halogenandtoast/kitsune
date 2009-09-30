module Kitsune
  module Page
    def self.included(model)
      model.class_eval do
        no_admin
        
        before_save :update_url
        
        def update_url
          @url = title
        end
      end
    end
  end
end