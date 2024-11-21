# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    begin
      @user = User.find(params[:id])
      @profile = @user.profile # 対応するプロフィールを取得
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
    end
  end

  def search
    @query = params[:query] # 検索キーワードを取得
    if @query.present?
      # profilesテーブルでusernameを検索
      @profiles = Profile.where("username LIKE ?", "%#{@query}%")
      @users = @profiles.map(&:user) # 関連するユーザーを取得
    else
      @users = []
    end
  end  
end