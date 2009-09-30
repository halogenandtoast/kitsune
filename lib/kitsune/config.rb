module Kitsune
  class Config
    @load_paths = %W[#{RAILS_ROOT}/app/models]
    @collection_label_methods = %w[to_label display_name full_name name title username login value to_s]
    def collection_label_methods
      @collection_label_methods
    end
  end
end