class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in, :authenticate_user

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!current_user.nil?
  end

  def authenticate_user
    if !logged_in?
      redirect_to login_path, alert: 'You must be signed in to access your lists'
    elsif params[:user_id] && params[:user_id].to_i != current_user.id
      redirect_to user_lists_path(current_user), alert: 'You can only access lists that belong to you'
    end
  end

end
