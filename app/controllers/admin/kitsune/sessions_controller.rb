class Admin::Kitsune::SessionsController < Admin::Kitsune::KitsuneController
  skip_before_filter :authenticate, :load_models
  layout 'admin/kitsune'
  def new
    
  end
  
  def create
    @user = KitsuneUser.authenticate(params[:session][:email], params[:session][:password])
    if @user.nil?
      flash[:notice] = "Could not log you in"
      render 'new'
    else
      sign_in(@user)
      redirect_back_or(url_for(:controller => 'admin/kitsune/models'))
    end
  end
  
  def destroy
    sign_out
    redirect_to(url_for(:controller => 'admin/kitsune/models'))
  end
end