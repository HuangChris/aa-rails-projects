class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user


  def login!(user)
    # user = User.find_by_credentials(user_params)
    session[:session_token] = user.session_token
    user
  end

  def current_user
    if session[:session_token]
      @user ||= User.current_user(session[:session_token])
    else
      nil
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def already_logged_in
    if current_user
      flash[:errors] = ["You are logged in already!"]
      redirect_to cats_url
    end
  end

  def require_login
    unless current_user
      flash[:errors] = ["You need to log in to see that"]
      redirect_to login_url
    end
  end
end
