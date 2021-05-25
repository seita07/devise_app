class TimepostsController < ApplicationController
  def index
    @timeposts = Timepost.all.order(created_at: :desc)
  end

  def show
    @timepost = Timepost.find_by(id:params[:id])
    @timelikes_count = TimeLike.where(timepost_id: @timepost.id).count
    @comments = Comment.where(timepost_id: @timepost.id)
  end

  def new
    @timepost = Timepost.new
  end

  def create
    @timepost = current_user.timeposts.build(timepost_params)
    if @timepost.save
      flash[:success] = "methodpost created!"
      redirect_to timeposts_url
    else
      render 'new'
    end
  end

  def edit
    @timepost = Timepost.find_by(id:params[:id])
  end

  def update
    @timepost = Timepost.find(params[:id])
    if @timepost.update(timepost_params)
      redirect_to timeposts_url
    else
      render 'edit'
    end
  end

  def destroy
    Timepost.find_by(id:params[:id]).destroy
    flash[:success] = "投稿を削除しました"
    redirect_to timeposts_url
  end

  private

    def timepost_params
      params.require(:timepost).permit(:content,:time,:user_id)
    end

    def correct_user
      @timepost = Timepost.find_by(id: params[:id])
      if @timepost.user_id != current_user.id
        flash[:notice] = "権限がありません"
        redirect_to timeposts_url
      end
    end
end
