Rails.application.routes.draw do
  resources :projects
  resources :tasks, only: [:index, :show]
  resources :staffs
  resources :clients, only: [:index, :show]
  resources :forms, only: [:index, :show, :create, :destroy]
  resources :leave_types
  resources :timesheets
  resources :admins

  post "/staffs", to: "staffs#create"
  post "/admins", to: "admins#create"
  post "/login", to: "sessions#create"
  get "/me", to: "staffs#show"
  get "/mi", to: "admins#show"

  delete "/logout", to: "sessions#destroy"
end

