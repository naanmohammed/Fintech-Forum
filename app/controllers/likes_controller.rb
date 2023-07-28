class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(post: @post, author: current_user)

    if @like.save
      @like.update_post_likes_counter 
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), notice: 'Post was successfully liked.'
    else
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), alert: 'Failed to like the post.'
    end
  end
end
