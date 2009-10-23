require 'kitsune/builder'

module Kitsune
  module ActiveRecord  
    def setup_admin
      self.class_eval do
        class_inheritable_hash :kitsune_admin
        self.kitsune_admin = {
          :no_admin => false, 
          :multipart => false, 
          :display => {}, 
          :edit => {}, 
          :fields => {}, 
          :tabs => {}
        }
      end
    end
  
    def admin &block
      setup_admin
      Kitsune::Builder.generate(self, &block)
    end
  
    def no_admin
      setup_admin
      self.kitsune_admin[:no_admin] = true
    end
  end
end