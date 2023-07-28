class PostsController < ApplicationController
  def index
    # Logic for index action
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    # Logic for show action
    @post = Post.find(params[:id])
  end

end
