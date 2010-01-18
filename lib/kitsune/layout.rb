module Kitsune
  class Layout
    def initialize(layout_file)
      data = File.read(layout_file)
      @content_areas = data.scan(/yield\s+:(\w+)\s+/i).flatten.uniq
    end
    
    def content_areas
      @content_areas
    end
    
    def method_missing(method, *arg, &block)
    end
  end
end