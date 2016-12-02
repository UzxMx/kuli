Rails.application.routes.draw do
  resources :orders
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'wx-oauth' => 'home#wx_oauth'
end
