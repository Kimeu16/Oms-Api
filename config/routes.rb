Rails.application.routes.draw do
  resources :profiles
  resources :leave_calculations
  resources :managers
  resources :projects
  resources :tasks
  # resources :staffs
  resources :clients
  resources :forms
  resources :leave_types
  resources :timesheets
  resources :admins

  resources :staffs do
    member do
      get 'forms', to: 'staffs#forms'
      get 'tasks', to: 'staffs#tasks'
      get 'leave_calculations', to: 'staffs#leave_calculations'
      get 'timesheets', to: 'staffs#timesheets'
      get 'profile', to: 'staffs#profile'
    end
  end

  post "/staffs", to: "staffs#create"
  post "/admins", to: "admins#create"
  post "/login", to: "sessions#create"
  get "/me", to: "staffs#show"
  get "/mi", to: "admins#mi"

  get "/gen_pass/:id", to: "admins#gen_pass"

  delete "/logout", to: "sessions#destroy"
end

