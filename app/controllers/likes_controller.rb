class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @profile = Profile.find(params[:profile_id])
    @like = @profile.likes.create(user: current_user, field: params[:field])
    
    if @like.save
      redirect_to user_path(@profile.user), notice: "いいねを押しました。"
    else
      redirect_to user_path(@profile.user), alert: "いいねに失敗しました。"
    end
  end
end
