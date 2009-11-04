class Admin::Kitsune::ApplicationController < ActionController::Base
  before_filter :load_models
  
  private
  def load_models
    models = Kitsune.models_with_admin.map{ |m| Kitsune::Inspector.new(m) }
    # category_map = {}
    #    @models =[]
    #    models.each do |m|
    #      if m.category
    #        category_map[m.category] = [] unless category[m.category]
    #        category_map[m.category] << m
    #      else
    #        @models << m
    #      end
    #    end
    #    @models += category_map.to_a.map{|c| Hash[*c]}
    @models = models
  end
end