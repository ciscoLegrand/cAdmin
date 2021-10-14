Cadmin::Engine.routes.draw do
  mount Shrine.upload_endpoint(:cache) => "/upload"
  root to: "dashboard#index"
  
  get 'profile/index'
  get 'profile/edit'
  get 'profile/show'
  
  resources :locations
  resources :events
  resources :article_categories
  resources :tags
  resources :discounts  
  resources :web_modules
  resources  :users
  
  resources :conversations do 
    resources :messages
  end
  resources :main_services do
    resources :services
  end

  resources :articles do
    resources :comments
  end
  # get 'tags/:tag', to: 'articles#index', as: :tag
 
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
    get 'logout', to: 'user_sessions#destroy', as: :logout
    # delete 'signout' => 'user_sessions#destroy', as: :logout
  end

  # TODO: generate routes for admin and employees
  namespace :admin do
    devise_for :cadmin_user,
               class_name: "Cadmin::User",
               controllers: {
                   sessions: 'cadmin/admin/user_sessions'
               },
               skip: [:sessions, :registrations],
               path_names: { sign_out: 'logout' },
               path_prefix: :user
      devise_scope :cadmin_user do
      get 'login' => 'user_sessions#new', :as => :login
      post 'login' => 'user_sessions#create', :as => :create_new_session
    end
  end
end
