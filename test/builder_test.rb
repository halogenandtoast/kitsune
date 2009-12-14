require 'test_helper'
 
class BuilderTest < Test::Unit::TestCase
  context "The model" do
    should "respond to kitsune_admin" do
      assert Post.respond_to?(:kitsune_admin)
    end
  end
end