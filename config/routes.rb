Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' , to: 'welcome#index', as: 'welcome'
  get '/admin_login', to: 'admin#new', as: 'new_admin'
  post '/admin_login', to: 'admin#create', as: 'admin_login'
  resources :admin, only: [:index] do
    resources :posts, only: [:new, :edit, :create, :update, :delete]
  end
  resources :posts, only: [:index, :show]
end
