Rails.application.routes.draw do
  resources :projects, only: [:index, :show]
  resources :tasks, only: [:index, :show]
  resources :staffs, only: [:index, :show]
  resources :clients, only: [:index, :show]
  resources :leave_forms, only: [:index, :show]
  resources :leave_types, only: [:index, :show]
  resources :timesheets, only: [:index, :show]
end
