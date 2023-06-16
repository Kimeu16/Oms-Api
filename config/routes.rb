Rails.application.routes.draw do
  resources :projects
  resources :tasks, only: [:index, :show]
  resources :staffs, only: [:index, :show]
  resources :clients, only: [:index, :show]
  resources :leave_forms
  resources :leave_types
  resources :timesheets
  resources :admins, only: [:index, :show, :create, :destroy]

  post "/staff", to: "staffs#create"
  post "/admin", to: "admin#create"
  post "/login", to: "sessions#create"
  get "/me", to: "staffs#show"
  get "/mi", to: "admin#show"

  delete "/logout", to: "sessions#destroy"
end
