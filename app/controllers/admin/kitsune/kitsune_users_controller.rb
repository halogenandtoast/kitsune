class Admin::Kitsune::KitsuneUsersController < Admin::Kitsune::KitsuneController
  layout 'admin/kitsune'
  def index
    @users = KitsuneUser.paginate(:page => params[:page])
  end
  
  def new
    @user = KitsuneUser.new
  end
  
  def create
    @user = KitsuneUser.new(params[:kitsune_user])
    if @user.save
      flash[:notice] = "User was created"
      redirect_to url_for(:controller => 'admin/kitsune/kitsune_users', :action => 'index')
    else
      render 'new'
    end
  end
end