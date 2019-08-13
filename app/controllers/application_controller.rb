# Base class for all the controllers
class ApplicationController < ActionController::Base
  helper_method :current_chef, :logged_in?

  def current_chef
    if session[:chef_id]
      @current_user ||= ValidChefDecorator.find(session[:chef_id])
    else
      NullChefRecord.new
    end
  end

  def cache_chef_id(id)
    session[:chef_id] = id
    cookies.signed[:chef_id] = id
  end

  def logged_in?
    current_chef.id == session[:chef_id]
  end

  def require_chef
    return if logged_in?

    flash[:danger] = 'You must be logged in to perform this action !'
    redirect_to login_path
  end
end
