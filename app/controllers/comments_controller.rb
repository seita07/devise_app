class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to timeposts_url
    else
      flash.now[:alert] = 'コメントを入力してください。'
      redirect_to timeposts_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to timeposts_url
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      redirect_to users_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, timepost_id: params[:timepost_id])
  end
end
