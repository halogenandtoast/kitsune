class Admin::Kitsune::KitsuneController < Admin::Kitsune::ApplicationController
  before_filter :authenticate,:load_models
  skip_before_filter :verify_authenticity_token
  
  helper_method :current_user, :signed_in?, :signed_out?
  hide_action :current_user, :current_user=, :signed_in?, :signed_out?, :sign_in, :sign_out, :authenticate, :deny_access
  
  def current_user
    @_current_user ||= user_from_cookie
  end
  
  def current_user=(user)
    @_current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_in(user)
    if user
      user.remember_me!
      cookies[:remember_token] = {
        :value => user.remember_token,
        :expires => 1.year.from_now.utc
      }
      current_user = user
    end
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  def signed_out?
    current_user.nil?
  end
  
  def authenticate
    if Kitsune.authenticate
      deny_access unless signed_in?
    end
  end
  
  def deny_access(flash_message = nil)
    flash[:notice] = flash_message if flash_message
    redirect_to url_for(:controller => 'admin/kitsune/sessions', :action => 'new')
  end
  
  def user_from_cookie
    if token = cookies[:remember_token]
      KitsuneUser.find_by_remember_token(token)
    end
  end
  
  def redirect_back_or(default)
    redirect_to(return_to || default)
    clear_return_to
  end
  
  def return_to
    session[:return_to] || params[:return_to]
  end
  
  def clear_return_to
    session[:return_to] = nil
  end
  
  private
  def load_models
    models = Kitsune.models_with_admin.map{ |m| Kitsune::Inspector.new(m) }
    category_map = {}
    
    @models =[]
    models.each do |m|
      if m.category
        category_map[m.category] = [] unless category_map[m.category]
        category_map[m.category] << m
      else
        @models << m
      end
    end
    @models += category_map.to_a.map{|c| Hash[*c]}
    #@models = models
  end
end