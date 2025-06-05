Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    get "products/index"
    get "products/show"
    get "products/new"
    get "products/edit"
    resources :products
  end
  resources :products do
    resources :reviews, only: [:create, :destroy]
    get 'serve_file', on: :collection
    member do
      post :add_to_cart
    end
  end
  resources :carts, only: [:show] do
    member do
      post :add_item
      delete :remove_item
    end
  end
  resources :orders, only: [:new, :create, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: 'products#index'
end
