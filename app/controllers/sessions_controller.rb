class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credential(params[:user][:username], params[:user][:password])
    # User.create!(params)
    if user
      user.save!
      session_token = User.reset_session_token!
      session[session_token] = user.session_token
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

# class Dog
#   attr_reader my_hash
#   def initialize
#     @my_hash = {}
#   end
# end
# Dog.my_hash
