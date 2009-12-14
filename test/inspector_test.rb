require 'test_helper'
 
class InspectorTest < Test::Unit::TestCase
  context "The model" do
    setup do
      @post = Kitsune::Inspector.new(Post)
    end
    
    should "be true" do
      assert true
    end
  end
end