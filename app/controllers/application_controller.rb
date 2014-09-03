class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def admin_user
      @admin_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
    end

    helper_method :admin_user

    def admin_signed_in?
      !admin_user.nil?
    end

    helper_method :admin_signed_in?

    def require_admin_signin!
      if admin_user.nil?
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to admin_signin_url
      end
    end

    helper_method :require_admin_signin!

end
