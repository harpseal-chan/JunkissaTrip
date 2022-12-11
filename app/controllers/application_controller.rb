class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_q

  private

    def logged_in_user
      return if logged_in?

      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end

    def set_q
      @q = Shop.ransack(params[:q])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
