class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  def create
    @review = Review.new(review_params)
    if @review.save
      flash.now[:notice] = 'レビューに成功しました'
      redirect_to "/methodposts/#{@review.methodpost_id}"
    else
      flash.now[:alert] = 'レビューに失敗しました'
      redirect_to "/methodposts/#{@review.methodpost_id}"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to methodposts_url
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      redirect_to "/methodposts/#{@review.methodpost_id}"
    end
  end

  private

  def review_params
    params.require(:review).permit(:text, :evaluation, :methodpost_id).merge(user_id: current_user.id)
  end
end
