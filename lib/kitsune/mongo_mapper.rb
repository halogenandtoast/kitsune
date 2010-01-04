require 'kitsune/builder'

module Kitsune
  module MongoMapper  
    def setup_admin
      self.class_eval do
        class_inheritable_hash :kitsune_admin
        self.kitsune_admin = {
          :no_admin => false, 
          :multipart => false, 
          :display => {}, 
          :edit => {}, 
          :reflections => {},
          :fields => {}, 
          :tabs => {},
          :is_sti => false,
					:disabled => [],
					:versioned => false,
					:order_by => nil,
					:media => nil # class to store images into
        }
      end
    end
  
    def admin &block
      setup_admin unless self.respond_to?(:kitsune_admin)
      Kitsune::Builder.generate(self, &block) unless self.kitsune_admin[:no_admin]
    end
  
    def no_admin
      setup_admin
      self.kitsune_admin[:no_admin] = true
    end
    TRANSPOSE = {String => :string}
    def columns
      self.keys.map do |key, value|
        FauxColumn.new(key, TRANSPOSE[value.type], key == '_id')
      end
    end
    
    def reflections
      {}
    end
    
    def class_name
      self.to_s
    end
  end
end
