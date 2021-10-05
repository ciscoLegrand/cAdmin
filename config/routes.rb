Cadmin::Engine.routes.draw do
  resources :locations
  resources :services
  resources :events
  mount Shrine.upload_endpoint(:cache) => "/upload"
  resources :article_categories
  resources :tags
  
  root to: "dashboard#index"
  resources :web_modules
  
  resources :articles do
    resources :comments
  end
  # get 'tags/:tag', to: 'articles#index', as: :tag

  match '/usuarios', to: 'users#index', via: :get, as: :users  
  # # devise_for :cadmin_users, class_name: "Cadmin::User", module: :devise
  # devise_for :users, controllers: { invitations: 'devise/invitations' }
  devise_for  :cadmin_users, 
              class_name: "Cadmin::User" , 
              controllers: { 
                sessions: 'cadmin/user_sessions', 
                registrations: 'cadmin/user_registrations',
                invitations: 'cadmin/user_invitations'
               },
               path_names: {sign_out: 'logout'},
               path_prefix: :user,
               module: :cadmin

  devise_scope :cadmin_user do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create', as:  :create_new_session
    get 'register', to: 'user_registrations#new', as: :register
    post 'register', to: 'user_registrations#create', as: :registration
    get 'profile', to: 'user_registrations#edit', as: :edit_profile
    put 'profile', to: 'user_registrations#update', as: :update_profile
    get 'logout', to: 'users_sessions#destroy', as: :logout
    # delete 'signout' => 'user_sessions#destroy', as: :logout
  end

  
end
