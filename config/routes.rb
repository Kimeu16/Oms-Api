Rails.application.routes.draw do
  resources :tasks do
    # Other member routes...
    collection do
      get 'completed_tasks', to: 'tasks#completed_tasks'
    end

    # Move the completed_files route outside of the member block
    put 'upload_completed_files', to: 'tasks#upload_completed_files', as: 'upload_completed_files'

    # Custom member route for downloading the avatar_image
    get 'download_avatar', on: :member, to: 'tasks#download_avatar', as: 'download_avatar'

    # get 'download_completed_file', on: :member, to: 'tasks#download_completed_file', as: 'download_completed_file'

    get 'download_completed_file/:file_index', action: :download_completed_file, as: 'download_completed_file'

  end


  resources :profiles
  resources :leave_calculations
  resources :managers
  resources :projects
  resources :leave_types
  resources :end_timesheets
  resources :timesheets, except: [:new, :edit], defaults: { format: 'json' }
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
      get 'end_timesheets', to: 'staffs#end_timesheets'
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

