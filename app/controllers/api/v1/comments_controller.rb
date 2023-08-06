module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }
      before_action :authenticate_user

      def index
        post = Post.find(params[:post_id])
        comments = post.comments
        render json: comments
      end

      def create
        post = Post.find(params[:post_id])
        comment = post.comments.new(comment_params)
        comment.author = @current_user

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end

      def authenticate_user
        @current_user = authenticate_with_http_token do |token|
          User.find_by(api_token: token)
        end

        unless @current_user
          render json: { errors: ['Invalid API token'] }, status: :unauthorized
        end
      end
    end
  end
end
