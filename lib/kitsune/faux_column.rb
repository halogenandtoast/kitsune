module Kitsune
  class FauxColumn
    attr_accessor :name, :type
    def initialize(name, type)
      @name, @type = name, type
    end
    def primary
      false
    end
  end
end