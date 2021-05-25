class ReviewsController < ApplicationController
    def create
        @review = Review.new(review_params)
        if @review.save
          redirect_to methodposts_url
        else
          flash.now[:alert] = 'コメントを入力してください。'
          redirect_to methodposts_url
        end
    end

    def destroy
        @review = Review.find(params[:id])
        if @review.destroy
            redirect_to methodposts_url
          else
            flash.now[:alert] = 'コメント削除に失敗しました'
            redirect_to users_url
        end
    end

    
    private
    def review_params
      params.require(:review).permit(:text,:evaluation).merge(user_id: current_user.id, methodpost_id: params[:methodpost_id])
    end
end
