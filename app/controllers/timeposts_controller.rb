class TimepostsController < ApplicationController
  def index
    @timeposts = Timepost.all.order(created_at: :desc)
  end

  # def show
  #   @timepost = Timepost.find_by(id:params[:id])
  #   @timelikes_count = TimeLike.where(timepost_id: @timepost.id).count
  #   @comments = Comment.where(timepost_id: @timepost.id)
  # end

  def report
    gon.day = get_day
    gon.study_time = get_eachsubject_weekly_totaltime 
    @day_totaltime = dayly_total_studytime
    @weel_totaltime = weekly_total_studytime
    @month_totaltime = month_total_studytime
  end


  def new
    @timepost = Timepost.new
  end

  def create
    @timepost = current_user.timeposts.build(timepost_params)
    @timepost.studytime = @timepost.time*60 + @timepost.minitus
    if @timepost.save
      flash[:notice] = "#{@timepost.studytime}分がんばりました"
      redirect_to timeposts_url
    else
      flash[:alert] = "methodpost alert"
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

  def get_day
    today = Time.current
    week_list = []
    day_list = [today.ago(6.days),today.ago(5.days),today.ago(4.days),today.ago(3.days),today.ago(2.days),today.ago(1.days),today]
    for day in day_list do
      week_list.push(day.strftime('%m-%d'))
    end
    return week_list
  end

  SUBJECT_LIST = ["国語","現代文","古文","漢文","数学","数学I・A","数学II・B","数学III","英語","英単語","英文法","英文解釈","英長文","リスニング",
                  "日本史","世界史","倫理","政治経済","地理","現代社会","物理","化学","生物","地学","過去問"]

  def get_eachsubject_weekly_totaltime
    subject_total_study_list = []
    for subject in SUBJECT_LIST do
      week_study_time_list = []
      for i in 0..6 do
        day_study_time_list = []
        search_date = Date.today-i 
        today_studytime_posts = Timepost.where('datetime': search_date.in_time_zone.all_day).where(subjects: subject).where(user_id:current_user.id)
        if !today_studytime_posts.empty?
          for today_studytime_post in today_studytime_posts do
            day_study_time_list.push(today_studytime_post.studytime)
          end
        else
          day_study_time_list.push(0) 
        end
        week_study_time_list.push(day_study_time_list.sum)
      end
      subject_total_study_list.push(week_study_time_list)
    end
    return subject_total_study_list
  end


  def dayly_total_studytime
    dayly_posts = []
    subjects_dayly_totaltime_list = []
    for subject in SUBJECT_LIST do
      today_studytime_posts = Timepost.where('datetime': Date.today.in_time_zone.all_day).where(subjects: subject).where(user_id:current_user.id)
      for post in today_studytime_posts do
        dayly_posts.push(post.studytime)
        subjects_dayly_totaltime_list.push(dayly_posts.sum)
      end
    end
    return subjects_dayly_totaltime_list.sum
  end

  def weekly_total_studytime
    weekly_totaltime_list = []
    today = Time.current.at_end_of_day
    from = today - 6.day 
    studytime_posts = Timepost.where('datetime': from...today).where(user_id:current_user.id)
    for post in studytime_posts do
      weekly_totaltime_list.push(post.studytime)
    end
   return weekly_totaltime_list.sum
  end

  def month_total_studytime
    month_totaltime_list = []
    today = Time.current.at_end_of_day
    from = today - 30.day 
    studytime_posts = Timepost.where('datetime': from...today).where(user_id:current_user.id)
    for post in studytime_posts do
      month_totaltime_list.push(post.studytime)
    end
   return month_totaltime_list.sum
  end


  private

  def timepost_params
    params.require(:timepost).permit(:content,:datetime,:studytime,:subjects,:time,:minitus,:user_id,:img)
  end

    # def correct_user
    #   @timepost = Timepost.find_by(id: params[:id])
    #   if @timepost.user_id != current_user.id
    #     flash[:notice] = "権限がありません"
    #     redirect_to timeposts_url
    #   enssss
    # end
end