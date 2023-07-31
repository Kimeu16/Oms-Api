Rails.application.routes.draw do
  resources :tasks do
    member do
      # Other member routes...
      # Move the completed_files route outside of the member block
      post 'upload_completed_files', to: 'tasks#upload_completed_files', as: 'upload_completed_files'
    end
    collection do
      # Move the completed_tasks route inside the collection block
      get 'completed_tasks', to: 'tasks#completed_tasks'
    end
  end
  
  resources :profiles
  resources :leave_calculations
  resources :managers
  resources :projects

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

