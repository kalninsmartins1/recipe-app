# Class for controlling chef sessions to login and out of application
class SessionsController < ApplicationController
  def new; end

  def create
    chef = ValidChefDecorator.find_by(email: session_params[:email])

    if chef.authenticate(session_params[:password] || ' ')
      cache_chef_id(chef.id)
      flash[:success] = 'You have successfully logged in !'
      redirect_to chef_path(chef)
    else
      flash.now[:danger] = 'There was something wrong !'
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = 'You have successfully logged out !'
    redirect_to root_path
  end

  private

  def session_params
    params[:session] || {}
  end
end
