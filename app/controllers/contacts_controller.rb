class ContactsController < ApplicationController
  before_filter :signed_in_user
  before_filter :load_correct_user

  # GET /contacts
  def index
    @contacts = @user.contacts
  end

  # GET /contacts/1
  def show
    @contact = @user.contacts.find(params[:id])
  end

  # GET /contacts/new
  def new
    @contact = @user.contacts.build
  end

  # GET /contacts/1/edit
  def edit
    @contact = @user.contacts.find(params[:id])
  end

  # POST /contacts
  def create
    @contact = @user.contacts.build(params[:contact])

    if @contact.save
      @contact.schedule_birthday_meeting
      redirect_to [@user, @contact]
    else
      render action: "new"
    end
  end

  # PUT /contacts/1
  def update
    @contact = @user.contacts.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to [@user, @contact]
    else
      render action: "edit"
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact = @user.contacts.find(params[:id])
    @contact.destroy
    redirect_to user_contacts_url(@user)
  end

  private

  def load_correct_user
    @user = User.find(params[:user_id]) if User.exists?(params[:user_id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
