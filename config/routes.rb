Cadmin::Engine.routes.draw do
  mount Shrine.upload_endpoint(:cache) => "/upload"
  root to: "dashboard#index"
  
  # custom routes
  get 'profile/index'
  get 'profile/edit'
  get 'profile/show'
  # get 'tags/:tag', to: 'articles#index', as: :tag
  match '/',                  to: "dashboard#index",          via: :get,      as: :dashboard
  match '/agenda',            to: "dashboard#agenda",         via: :get,      as: :agenda
  match '/interviews',        to: "interviews#index",         via: :get,      as: :interviews
  match '/interviews/:id',    to: "interviews#show",          via: :get,      as: :interview
  # match '/users', to: "users#index",  via: :get, as: :users
  # match '/charged', to: "events#charged", via: :get, as: :charged
  # match '/events/:id/charged', to: "events#charged", via: :put, as: :charged
  
  # scafold resources
  resources :article_categories
  resources :discounts
  resources :event_types
  resources :locations
  resources :tags
  resources :tracks
  resources :users  
  resources :web_modules
    
  resources :articles do
    resources :comments
  end
  resources :conversations do 
    resources :messages
  end

  resources :email_base_templates do
    resources :email_custom_templates, except: %w[show]
  end

  resources :events do
    resources :interviews  
  end
  
  resources :events do
    get 'booked',  on: :member
    get 'charged', on: :member 
    get 'cancel',  on: :member
  end

  resources :main_services do
    resources :services
  end

  # cart actions
  match 'cart', to: "carts#index",  via: :get, as: :cart
  resources :cart_items, only: %w[create destroy]
  get "/add/:service_id", to: "cart_items#create", as: :add_to_cart
  
  # payment routes
  # stripe webhooks
  resources :webhooks, only: %w[create]
  # stripe checkout
  get   'checkout/create',    to: 'checkout#create'
  post  'checkout/create',    to: 'checkout#create'
  get   'success',            to: 'checkout#success'
  get   'cancel',             to: 'checkout#cancel'
  
  # user authentication routes 
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
    get  'login',        to: 'user_sessions#new',              as: :login
    post 'login',        to: 'user_sessions#create',           as: :create_new_session
    get  'register',     to: 'user_registrations#new',         as: :register
    post 'register',     to: 'user_registrations#create',      as: :registration
    get  'profile',      to: 'user_registrations#edit',        as: :edit_profile
    put  'profile',      to: 'user_registrations#update',      as: :update_profile
    get  'logout',       to: 'user_sessions#destroy',          as: :logout
    # delete 'signout' => 'user_sessions#destroy', as: :logout
  end

  # TODO: generate routes for admin and employees
  # namespace :admin do
  #   devise_for :cadmin_user,
  #               class_name: "Cadmin::User",
  #               controllers: {
  #                 sessions: 'cadmin/admin/user_sessions'
  #               },  
  #               skip: [:sessions, :registrations],
  #               path_names: { sign_out: 'logout' },
  #               path_prefix: :user
  #   devise_scope :cadmin_user do
  #     get 'login' => 'user_sessions#new', :as => :login
  #     post 'login' => 'user_sessions#create', :as => :create_new_session
  #   end
  # end

  # SPOTIFY API
  namespace :api do 
    namespace :v1 do 
      resources :tracks do 
        collection do 
          get :top_100
          get :random 
          get :search 
        end 
      end 
    end 
  end
end
