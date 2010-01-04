module Kitsune
  class FauxColumn
    attr_accessor :name, :type, :primary
    def initialize(name, type, primary = false)
      @name, @type, @primary = name, type, primary
    end
  end
end