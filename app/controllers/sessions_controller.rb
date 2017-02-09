class SessionsController < ApplicationController
  def create
    user = User.find_by_username(user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    render status: :ok
  end

  private

  def user_params
    params[:params][:user].permit(:username, :password)
  end
end
