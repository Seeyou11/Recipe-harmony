Rails.application.routes.draw do
  resources :recipes
  resources :categories
  devise_for :users  
    patch '/users/:id/switch_role', to: 'users#switch_role', as: 'switch_role_user'
    get '/users/:id/switch_role', to: 'users#switch_role' 
   delete 'users/:id', to: 'users#destroy' or resources :users, only: [:destroy]  
   
    resources :users, only: [:destroy] do
    member do
      get :assign_roles
      patch :update_roles
    end
  end
  
  root "home#index"
  
  resources :roles

  post "toggle_like", to:  "likes#toggle_like", as: :toggle_like
  post "toggle_favorite", to:  "favorites#toggle_favorite", as: :toggle_favorites
  resources :comments, only: [:create, :destroy]
  resources :users, only: [:show, :index]

  post "follow", to: 'follows#follow', as: :follow
  delete 'unfollow', to: 'follows#unfollow', as: :unfollow
  delete 'cancel_request', to: 'follows#cancel_request', as: :cancel_request

  post 'accept_follow', to: 'follows#accept_follow', as: :accept_follow
  delete 'decline_follow', to: 'follows#decline_follow', as: :decline_follow


end
