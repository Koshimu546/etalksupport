Rails.application.routes.draw do
  devise_for :users, controllers: {
    
    omniauth_callbacks: "users/omniauth_callbacks"
  }

    get    "/help",    to: "pages#help"
    get    "/about",   to: "pages#about"
    get    "/contact", to: "pages#contact"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'application#index'
end