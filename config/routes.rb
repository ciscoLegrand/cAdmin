Cadmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :web_modules
end
