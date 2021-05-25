class MethodpostsController < ApplicationController
  
    def index
      @methodposts = Methodpost.all.order(created_at: :desc)
    end
  
    def show
      @methodpost = Methodpost.find_by(id:params[:id])
      @methodlikes_count = MethodLike.where(methodpost_id: @methodpost.id).count
      # @reviews = Review.where(methodpost_id: @methodpost.id)
      @reviews = Review.new
    end
  
    def new
      @methodpost = Methodpost.new
    end
  
    def create
      @methodpost = current_user.methodposts.build(methodpost_params)
      if @methodpost.save
        flash[:success] = "methodpost created!"
        redirect_to methodposts_url
      else
        render 'new'
      end
    end
  
    def edit
      @methodpost = Methodpost.find_by(id:params[:id])
    end
  
    def update
      @methodpost = Methodpost.find(params[:id])
      if @methodpost.update(methodpost_params)
        redirect_to methodposts_url
      else
        render 'edit'
      end
    end
  
    def destroy
      Methodpost.find_by(id:params[:id]).destroy
      flash[:success] = "投稿を削除しました"
      redirect_to methodposts_url
    end
  
    private
  
      def methodpost_params
        params.require(:methodpost).permit(:content,:time,:user_id,:subjects)
      end
  
      def correct_user
        @methodpost = methodpost.find_by(id: params[:id])
        if @methodpost.user_id != current_user.id
          flash[:notice] = "権限がありません"
          redirect_to methodposts_url
        end
      end
  end
  