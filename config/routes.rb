# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:show]

  get "/help", to: "pages#help"

  # ルート設定: mypage をホームとして設定
  root "pages#mypage"
end

