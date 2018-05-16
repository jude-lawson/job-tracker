Rails.application.routes.draw do
  # resources :companies do
  #   resources :jobs, except: [:new, :create]
  # end

  # resources :jobs, only: [:new, :create]

  # resources :jobs
#   resources :companies, only: [:show]

  resources :jobs do
    resources :comments
  end
  resources :companies do
    resources :contacts
    resources :jobs, only: [:index]
    #resources :jobs
  end
  resources :categories, only: [:index, :new, :create, :destroy, :edit, :update] do
    resources :jobs, only: [:index]
  end
end
