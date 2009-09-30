module Kitsune
  module ActiveRecord
    def self.included(base)
      base.class_eval do
        class_inheritable_hash :kitsune_admin
        class << self
          def no_admin
            self.kitsune_admin ||= {
              :no_admin => true
            }
          end
          def admin(&block)
            self.kitsune_admin ||= {
              :display => {},
              :edit => {}
            }
            Kitsune::Admin::Builder.generate(self, &block)
          end
        end
      end
    end
  end
end