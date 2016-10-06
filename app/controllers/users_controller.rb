class UsersController < ApplicationController

  before_action :prevent_redundant_login

  def new

  end

  def create
    user = User.new(users_params)
    if user.save
      login(user)
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  private
  def users_params
    params.require(:user).permit(:user_name, :password)
  end
end
