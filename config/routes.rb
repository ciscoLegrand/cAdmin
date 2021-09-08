Cadmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :web_modules
  
  devise_for :users, class_name: "Cadmin::User"
end
