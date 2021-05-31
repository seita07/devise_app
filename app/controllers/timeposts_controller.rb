class TimepostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @timeposts = Timepost.all.order(created_at: :desc)
  end

  def new
    @timepost = Timepost.new
  end

  def create
    @timepost = current_user.timeposts.build(timepost_params)
    @timepost.studytime = @timepost.time * 60 + @timepost.minitus
    if @timepost.save
      flash[:notice] = "#{@timepost.studytime}分がんばりました"
      redirect_to timeposts_url
    else
      flash[:alert] = '記録できませんでした'
      render 'new'
    end
  end

  def edit
    @timepost = Timepost.find_by(id: params[:id])
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
    Timepost.find_by(id: params[:id]).destroy
    flash[:success] = '投稿を削除しました'
    redirect_to timeposts_url
  end

  private

  def timepost_params
    params.require(:timepost).permit(:content, :datetime, :studytime, :subjects, :time, :minitus, :user_id, :img)
  end
end
