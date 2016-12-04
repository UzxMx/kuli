Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/fill_info' => 'users#fill_info_view'
  post 'users/fill_info' => 'users#fill_info'

  get 'users/show' => 'users#show'

  resources :stores
  resources :orders
end
