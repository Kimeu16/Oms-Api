Rails.application.routes.draw do
  # Mount ActionCable for WebSocket communication
  mount ActionCable.server => '/cable'

  # Routes for sending messages
  scope '/messages' do
    # Route to send a message to an admin
    post '/send_to_admin/:admin_id', to: 'messages#send_to_admin', as: 'send_to_admin_message'

    # Route to send a message to a staff member
    post '/send_to_staff/:staff_id', to: 'messages#send_to_staff', as: 'send_to_staff_message'

    # Route to retrieve received messages
    get '/received_messages', to: 'messages#received_messages', as: 'received_messages'

    # Route to retrieve sent messages
    get '/sent_messages', to: 'messages#sent_messages', as: 'sent_messages'

    # Route to update a message
    put '/:id', to: 'messages#update', as: 'update_message'

    # Route to delete a message
    delete '/:id', to: 'messages#destroy', as: 'destroy_message'
  end

  # Routes for tasks
  resources :tasks do
    collection do
      # Route to retrieve completed tasks
      get 'completed_tasks', to: 'tasks#completed_tasks'

      # Route to retrieve tasks received by an admin
      get 'admin_received_tasks', to: 'tasks#admin_received_tasks'

      # Route to retrieve tasks received by staff members
      get 'received_tasks', to: 'tasks#received_tasks'

      # Route to retrieve tasks sent by an admin to staff members
      get 'admin_sent_tasks_to_staff', to: 'tasks#admin_sent_tasks_to_staff'

      # Route to retrieve all tasks for an admin
      get 'admin_all_tasks', to: 'tasks#admin_all_tasks'

      # Route to retrieve completed files received by an admin
      get 'admin_received_completed_files', to: 'tasks#admin_received_completed_files'
    end

    # Route to upload completed files for a task
    put 'upload_completed_files', to: 'tasks#upload_completed_files', as: 'upload_completed_files'

    # Route to download the avatar associated with a task
    get 'download_avatar', on: :member, to: 'tasks#download_avatar', as: 'download_avatar'

    # Route to download a completed file associated with a task by index
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


 # Routes for staff members
 resources :staffs do
  member do
    # Route to retrieve forms for a staff member
    get 'forms', to: 'staffs#forms'

    # Route to retrieve tasks assigned to a staff member
    get 'tasks', to: 'staffs#tasks'

    # Route to retrieve leave calculations for a staff member
    get 'leave_calculations', to: 'staffs#leave_calculations'

    # Route to retrieve timesheets for a staff member
    get 'timesheets', to: 'staffs#timesheets'

    # Route to retrieve end timesheets for a staff member
    get 'end_timesheets', to: 'staffs#end_timesheets'

    # Route to retrieve profile information for a staff member
    get 'profile', to: 'staffs#profile'
  end
end

# Routes for check-ins and check-outs
resources :check_in_outs, only: [:index, :show, :destroy]
post 'check_in_outs/check_in', to: 'check_in_outs#check_in'
post 'check_in_outs/check_out', to: 'check_in_outs#check_out'

# Custom routes for creating staff and admin users
post "/staffs", to: "staffs#create"
post "/admins", to: "admins#create"

# Authentication routes
post "/login", to: "sessions#create"
delete "/logout", to: "sessions#destroy"
get "/me", to: "staffs#show"
get "/mi", to: "admins#mi"

# Route for generating a password for an admin
get "/gen_pass/:id", to: "admins#gen_pass"
end
