class SessionsController < ApplicationController
  def new
    redirect_to today_user_meetings_path(current_user) if signed_in?
  end

  def create
  	user = User.find_by_user_name(params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or today_user_meetings_path(current_user)
    else
      render 'new', alert: "Wrong username or password."
    end
  end

  def destroy
  	sign_out
    redirect_to root_path
  end
end
