class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_q

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

    def set_q
      @q = Shop.ransack(params[:q])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
