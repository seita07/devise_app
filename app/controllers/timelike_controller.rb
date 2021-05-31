class TimelikeController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  def create
    @timelike = TimeLike.new(user_id: current_user.id, timepost_id: params[:timepost_id])
    @timelike.save
    redirect_to('/timeposts')
  end

  def destroy
    @timelike = TimeLike.find_by(user_id: current_user.id, timepost_id: params[:timepost_id])
    @timelike.destroy
    redirect_to('/timeposts')
  end
end
