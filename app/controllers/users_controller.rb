# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
    end
  end
end
