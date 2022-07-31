class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render404
  rescue_from ActionController::RoutingError, with: :render404

  def render404
    render template: 'errors/404', status: :not_found
  end

  private

    def logged_in_user
      return if logged_in?

      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end

    def correct_user
      @user = User.find(params[:id])
      Rails.logger.debug @user.inspect
      return if current_user?(@user)

      flash[:danger] = '無効なページです'
      redirect_to root_url
    end
end
