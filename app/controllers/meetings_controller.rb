class MeetingsController < ApplicationController
  before_filter :signed_in_user
  before_filter :load_correct_user

  # GET /today
  def today
    @meetings = @user.today_shedule
  end

  # GET /search
  def search
    if params[:contact_name] && params[:contact_name] != ""
      @meetings = @user.search_meetings(params[:contact_name])
    else 
      @meetings = @user.meetings.all
    end
  end

  # GET /meetings
  def index
    @meetings = @user.meetings.all
  end

  # GET /meetings/1
  def show
    @meeting = @user.meetings.find(params[:id])
  end

  # GET /meetings/news
  def new
    @meeting = @user.meetings.build
  end

  # GET /meetings/1/edit
  def edit
    @meeting = @user.meetings.find(params[:id])
  end

  # POST /meetings
  def create
    @meeting = @user.meetings.build(params[:meeting])
    if @meeting.save
      redirect_to [@user, @meeting]
    else
      render action: "new"
    end
  end

  # PUT /meetings/1
  def update
    @meeting = @user.meetings.find(params[:id])
    if @meeting.update_attributes(params[:meeting])
      redirect_to [@user, @meeting]
    else
      render action: "edit"
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting = @user.meetings.find(params[:id])
    @meeting.destroy
    redirect_to user_meetings_url(@user)
  end

  private

  def load_correct_user
    @user = User.find(params[:user_id]) if User.exists?(params[:user_id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
