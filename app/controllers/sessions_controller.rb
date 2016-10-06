class SessionsController < ApplicationController

  before_action :prevent_redundant_login
  skip_before_action :prevent_redundant_login, only: [:destroy]

  def new
  end

  def destroy
    return nil if current_user.nil?
    logout(current_user)
    redirect_to cats_url
  end

  def create
    user = User.find_by_credentials(session_params[:user_name], session_params[:password])

    if user.nil?
      redirect_to new_session_url
    else
      login(user)
      redirect_to cats_url
    end
  end

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
