Rails.application.routes.draw do
  resources :managers
  resources :projects
  resources :tasks
  resources :staffs
  resources :clients
  resources :forms
  resources :leave_types
  resources :timesheets
  resources :admins

  post "/staffs", to: "staffs#create"
  post "/admins", to: "admins#create"
  post "/login", to: "sessions#create"
  get "/me", to: "staffs#show"
  get "/mi", to: "admins#show"

  get "/gen_pass/:id", to: "admins#gen_pass"

  delete "/logout", to: "sessions#destroy"
end

