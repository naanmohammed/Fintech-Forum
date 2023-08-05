class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :api_request?
  before_action :update_allowed_parameters, if: :devise_controller?, unless: :api_request?
  protect_from_forgery with: :exception, unless: :api_request?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :bio, :email, :password, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :bio, :email, :password, :photo])
  end

  def api_request?
    controller_path.starts_with?("api/")
  end
end
