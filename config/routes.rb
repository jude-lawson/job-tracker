Rails.application.routes.draw do
  resources :jobs do
    resources :comments
  end
  resources :companies do
    resources :contacts
    resources :jobs, only: [:index]
  end
  resources :categories, only: [:index, :new, :create, :destroy, :edit, :update] do
    resources :jobs, only: [:index]
  end

  get '/dashboard', to: 'jobs#dashboard'
end
