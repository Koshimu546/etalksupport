# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @profile = current_user.build_profile
  end

  # app/controllers/profiles_controller.rb
  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to user_path(current_user), notice: 'プロフィールが登録されました。'
    else
      flash.now[:alert] = 'プロフィールの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_path(current_user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end  

  private

  def profile_params
    params.require(:profile).permit(:username, :doing, :hobbies, :comment)
  end
end

