Rails.application.routes.draw do
  resources :check_in_outs

  mount ActionCable.server => '/cable'

  scope '/messages' do
    post '/send_to_admin/:admin_id', to: 'messages#send_to_admin', as: 'send_to_admin_message'
    post '/send_to_staff/:staff_id', to: 'messages#send_to_staff', as: 'send_to_staff_message'
    # get '/received_messages', to: 'messages#received_messages'
    get '/received_messages', to: 'messages#received_messages', as: 'received_messages'
    # get '/sent_messages', to: 'messages#sent_messages'
    get '/sent_messages', to: 'messages#sent_messages', as: 'sent_messages'

    # Define routes for update and destroy actions
    put '/:id', to: 'messages#update', as: 'update_message'
    delete '/:id', to: 'messages#destroy', as: 'destroy_message'
  end

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
  resources :admins
  resources :company_articles
  resources :requests
  resources :progresses

  resources :check_ins, only: [:create] do
    member do
      patch 'check_out'
    end
  end

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

  resources :check_in_outs, only: [:index, :show, :destroy]

  post 'check_in_outs/check_in', to: 'check_in_outs#check_in'
  post 'check_in_outs/check_out', to: 'check_in_outs#check_out'

  post "/staffs", to: "staffs#create"
  post "/admins", to: "admins#create"
  post "/login", to: "sessions#create"
  get "/me", to: "staffs#show"
  get "/mi", to: "admins#mi"

  get "/gen_pass/:id", to: "admins#gen_pass"

  delete "/logout", to: "sessions#destroy"
end

