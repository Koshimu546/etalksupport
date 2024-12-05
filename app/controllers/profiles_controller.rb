class ProfilesController < ApplicationController
  before_action :authenticate_user!

  # プロフィール新規作成ページ
  def new
    @profile = current_user.build_profile
  end

  # プロフィールの登録処理
  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to user_path(current_user), notice: 'プロフィールが登録されました。'
    else
      flash.now[:alert] = 'プロフィールの登録に失敗しました。'
      render :new
    end
  end

  # プロフィール編集ページ
  def edit
    @profile = current_user.profile
  end

  # プロフィールの更新処理
  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_path(current_user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  # ランキングページ
  def ranking
    @doing_ranking = fetch_ranking("doing")
    @hobbies_ranking = fetch_ranking("hobbies")
    @comment_ranking = fetch_ranking("comment")
  end

  private

  # ストロングパラメータ
  def profile_params
    params.require(:profile).permit(:username, :doing, :hobbies, :comment)
  end

  # 共通のランキング取得ロジック
  def fetch_ranking(field)
    Profile.joins(:likes)
           .where(likes: { field: field })
           .group(:id)
           .order('COUNT(likes.id) DESC')
           .limit(10)
           .select('profiles.*, COUNT(likes.id) AS likes_count')
  end
end
