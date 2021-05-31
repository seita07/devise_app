class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def top
  end

  def show
    @user = User.find_by(id:params[:id])
    @following_users = @user.followings
    @follower_users = @user.followers
    @timeposts = Timepost.where(user_id:params[:id])
    gon.day = get_day
    gon.study_time = get_eachsubject_weekly_totaltime 
    @day_totaltime = dayly_total_studytime
    @weel_totaltime = weekly_total_studytime
    @month_totaltime = month_total_studytime
  end

  def guest_sign_in
    user = User.find_or_create_by!(name:'guest',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
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
        today_studytime_posts = Timepost.where('datetime': search_date.in_time_zone.all_day).where(subjects: subject).where(user_id:params[:id])
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
      today_studytime_posts = Timepost.where('datetime': Date.today.in_time_zone.all_day).where(subjects: subject).where(user_id:params[:id])
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
    studytime_posts = Timepost.where('datetime': from...today).where(user_id:params[:id])
    for post in studytime_posts do
      weekly_totaltime_list.push(post.studytime)
    end
   return weekly_totaltime_list.sum
  end

  def month_total_studytime
    month_totaltime_list = []
    today = Time.current.at_end_of_day
    from = today - 30.day 
    studytime_posts = Timepost.where('datetime': from...today).where(user_id:params[:id])
    for post in studytime_posts do
      month_totaltime_list.push(post.studytime)
    end
   return month_totaltime_list.sum
  end
end
