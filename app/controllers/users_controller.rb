class UsersController < ApplicationController
  def index
    # Logic for index action
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    # Logic for show action
    @user = User.find(params[:id])
    @user.posts_counter = @user.posts.count
  end

end
