class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
