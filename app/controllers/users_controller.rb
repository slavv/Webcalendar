class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show, :edit, :update, :delete]
  before_filter :correct_user, only: [:show, :edit, :update, :delete]

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def correct_user
      @user = User.find(params[:id]) if User.exists?(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
