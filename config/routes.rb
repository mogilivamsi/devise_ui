Rails.application.routes.draw do
  get 'users/index'
  get 'users/login_new'
  get 'users/logout'
  post 'users/login'
  post 'users/verify_login'
  get 'users/login_otp'
  get 'users/search'
  post 'users/signup'
  get 'users/signup_new'
  get 'users/forgot_password_new'
  post 'users/forgot_password'
  get 'users/reset_password'
  root to: "users#index"
  resources :users
  resources :recipes, only: %w(show index)
end
