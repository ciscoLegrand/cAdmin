Rails.application.routes.draw do
  mount Cadmin::Engine => "/cadmin"

  devise_for :users, {
    class_name: 'Cadmin::User',
    module: :devise
  }
end
