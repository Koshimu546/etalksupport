# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def mypage
    if user_signed_in?
      # ログインしている場合の内容
      render :mypage
    else
      # ログインしていない場合の内容
      render :home  # app/views/pages/home.html.erb を用意
    end
  end
end
