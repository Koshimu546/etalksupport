Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # ユーザー関連のルート
  resources :users, only: [:show] do
    collection do
      get 'search' # 検索機能用のルート
    end
  end

  resources :profiles, only: [:new, :create, :edit, :update] do
    collection do
      get 'ranking' # ランキングページのルート
    end
  end

  resources :profiles, only: [] do
    resources :likes, only: [:create]
  end

  # プロフィール関連のルート
  resources :profiles, only: [:new, :create, :edit, :update]

  # 固定ページのルート
  get "/help", to: "pages#help"

  # ルート設定: mypage をホームとして設定
  root "pages#mypage"

  #フォロー機能
  resources :relationships, only: [:create, :destroy]
end


