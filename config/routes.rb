Rails.application.routes.draw do
  # resources :companies do
  #   resources :jobs, except: [:new, :create]
  # end

  # resources :jobs, only: [:new, :create]
  resources :jobs do
    resources :comments
  end
  resources :companies, only: [:show] do
    resources :contacts
    #resources :jobs
  end
  resources :categories, only: [:new, :create] do
    resources :jobs, only: [:index]
  end
end
