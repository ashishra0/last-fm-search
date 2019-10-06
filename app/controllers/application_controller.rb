class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'Please login to continue'
      redirect_to login_path
    end
  end

  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end

end
