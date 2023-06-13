Rails.application.routes.draw do
  resources :timesheets
  resources :tasks
  resources :staffs
  resources :leave_forms
  resources :projects
  resources :leave_types
  resources :clients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
