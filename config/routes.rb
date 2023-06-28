Rails.application.routes.draw do
  #get "dashboards/index", as: :dashboards
  resources :logins, only: %i[new create]
  resources :registrations, only: %i[new create]
  # get 'registrations/new'
  # get 'registrations/create'  
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
