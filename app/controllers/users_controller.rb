class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :correct_or_admin_user, only: [:destroy]
  before_action :check_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @bookmark_shops = @user.bookmark_shops.preload(images_attachments: :blob)
    @comments = @user.comments.preload(:shop)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'アカウントを作成しました'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'アカウント情報を更新しました'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.avatar.purge
    user.destroy
    flash[:success] = 'アカウントを削除しました'
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def correct_user
      @user = User.find(params[:id])
      return if current_user?(@user)

      flash[:danger] = '無効なページです'
      redirect_to root_url
    end

    def correct_or_admin_user
      @user = User.find(params[:id])
      return if current_user?(@user) || current_user.admin?

      flash[:danger] = '無効なページです'
      redirect_to root_url
    end

    def check_guest_user
      user = User.find_by(email: "guest@example.com")
      return unless current_user?(user)

      flash[:danger] = 'ゲストユーザーはアカウント設定を変更できません'
      redirect_to root_url
    end
end
