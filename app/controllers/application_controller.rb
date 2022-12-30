class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def logged_in_user
      return if logged_in?

      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
