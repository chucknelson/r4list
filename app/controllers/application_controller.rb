class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :mobile_device?, :current_user, :logged_in?, :admin?, :authenticate_user

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!current_user.nil?
  end

  def admin?
    #hardcoded to me for now
    logged_in? and current_user.email == 'nelson.charles@gmail.com'
  end

  def authenticate_user
    if !logged_in?
      redirect_to login_path, alert: 'You must be signed in to access your lists'
    elsif params[:user_id] && params[:user_id].to_i != current_user.id
      redirect_to user_lists_path(current_user), alert: 'You can only access lists that belong to you'
    end
  end

  def authenticate_admin
    if !admin?
      redirect_to root_path, alert: 'You do not have access to that page'
    end
  end

end
