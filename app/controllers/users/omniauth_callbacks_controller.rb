# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    # 'request.env["omniauth.auth"]' には Google アカウントから取得したデータが含まれています
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      # sign_in_and_redirect をカスタムリダイレクトに変更
      sign_in @user, event: :authentication
      redirect_to user_path(@user)  # /users/:id にリダイレクト
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
