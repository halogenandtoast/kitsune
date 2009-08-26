module Kitsune
  module ActiveRecord
    def self.included(base)
      base.class_eval do
        class_inheritable_hash :kitsune_admin
        class << self
          def admin(&block)
            self.kitsune_admin ||= {}
            Kitsune::Admin::Builder.generate(self, &block)
          end
        end
      end
    end
  end
end