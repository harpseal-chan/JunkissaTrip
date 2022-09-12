class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = "ユーザーを削除しました"
    else
      flash[:danger] = "ユーザーの削除に失敗しました"
    end
  end
end
