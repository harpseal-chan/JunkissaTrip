class GuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by(email: "guest@example.com") do |guest_user|
      guest_user.password = User.new_token
      guest_user.name = "ゲストユーザー"
    end
    log_in user
    remember(user)
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_back_or user
  end
end
