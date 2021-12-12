Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  resources :events do
    get :publish
    get :republish
  end

  resources :parties
end
