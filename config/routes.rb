Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'sessions'
  }
  root 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/fill_info' => 'users#fill_info_view'
  post 'users/fill_info' => 'users#fill_info'

  get 'users/show' => 'users#show'

  resources :stores
  resources :orders

  devise_for :admin_users, class_name: "Admin::User", path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get '/', to: 'home#index'

    resources :users do
      resources :orders, only: [:index], controller: 'users/orders'
      resources :stores, only: [:index], controller: 'users/stores'
    end
    resources :orders
    resources :stores
  end
end
