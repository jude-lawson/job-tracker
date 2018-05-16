Rails.application.routes.draw do
  # resources :companies do
  #   resources :jobs, except: [:new, :create]
  # end

  # resources :jobs, only: [:new, :create]
  resources :jobs
  resources :companies, only: [:show]
  resources :categories, only: [:new, :create]
end
