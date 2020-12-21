Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'prototypes#index'
  resources :prototypes do
    resources :comments
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
