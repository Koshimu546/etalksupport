class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.following << user unless current_user == user
    redirect_to user_path(user), notice: "#{user.profile&.username || '名前未設定'}をフォローしました。"
  end

  def destroy
    user = User.find(params[:id])
    current_user.following.delete(user)
    redirect_to user_path(user), notice: "#{user.profile&.username || '名前未設定'}のフォローを解除しました。"
  end
end
