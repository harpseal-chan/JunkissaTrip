class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # before_action :correct_user, only: [:create, :destroy]

  def create
    @shop = Shop.find(params[:shop_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
    else
      flash[:danger] = 'コメントの投稿に失敗しました'
    end
    redirect_to @shop
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :shop_id, :content)
    end
end
