Rails.application.routes.draw do
  root "home#index"
  get 'export/export', :as => 'export', format: "xlsx"
  get '/user', to: 'rails_admin/main#dashboard', :as => :user_root
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
