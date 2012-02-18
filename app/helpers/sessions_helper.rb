module SessionsHelper
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def sign_in(user)
    session[:remember_token] = user.id
    current_user = user
  end

  def sign_out
    session[:remember_token] = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  private

    def user_from_remember_token
      User.find(session[:remember_token]) unless session[:remember_token].nil?
    end

    def clear_return_to
      session.delete(:return_to)
    end
end
