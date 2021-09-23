Cadmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :web_modules
  
  resources :articles do
    resources :comments
  end
  
  # devise_for :cadmin_users, class_name: "Cadmin::User", module: :devise
  devise_for  :cadmin_users, 
              class_name: "Cadmin::User" , 
              controllers: { 
                sessions: 'cadmin/user_sessions', 
                registrations: 'cadmin/user_registrations',
                registrations: 'cadmin/invitations'
               },
               path_names: {sign_out: 'logout'},
               path_prefix: :user,
               module: :cadmin

  devise_scope :cadmin_user do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create', as:  :create_new_session
    get 'register', to: 'user_registrations#new', as: :register
    post 'register', to: 'user_registrations#create', as: :registration
    # delete 'signout' => 'user_sessions#destroy', as: :logout
  end

  
end
