class ApiController < ApplicationController
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']&.split(' ')&.last
    @current_user = User.find_by(api_token: auth_token)
    return render_unauthorized if @current_user.nil?
  end
end
