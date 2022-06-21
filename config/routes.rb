Rails.application.routes.draw do
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  delete "/sign_out", to: "sessions#destroy"

  resources :users, only: [:show]
  resources :rooms, only: [:show]

  root "rooms#index"
end
