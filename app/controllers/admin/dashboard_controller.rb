class Admin::DashboardController < Admin::ApplicationController
  layout "admin"
  before_action :require_admin_signin!
  
  def index
    @categories = Category.by_position
  end


  private

    def require_admin_signin!
      if admin_user.nil?
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to admin_signin_path
      end
    end

end