class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    # @user.password = params[:user][:password]
    if @user.save
      redirect_to cats_url
    else
      render :new
    end
  end

  private
  def user_params
    self.params.require(:user).permit(:username, :password)
  end
end
