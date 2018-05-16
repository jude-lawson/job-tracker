Rails.application.routes.draw do
  resources :companies do
    resources :jobs
  end
end
