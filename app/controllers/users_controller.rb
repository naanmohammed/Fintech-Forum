class UsersController < ApplicationController
  def index
    # Logic for index action
    @users = User.all
  end

  def show
    # Logic for show action
    @user = User.find(params[:id])
    @user.posts_counter = @user.posts.count
  end

end
