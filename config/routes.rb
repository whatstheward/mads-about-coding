Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' , to: 'application#index', as: 'welcome'
  get '/admin_login', to: 'admin#new', as: 'new_admin'
  post '/admin_login', to: 'admin#create', as: 'admin_login'
  scope 'admin', as: 'admin' do
    resources :posts, only: [:new, :edit, :create, :update, :delete]
  end
  scope 'posts' do
    post '/filter', to: 'posts#filter', as: 'filter'
  end
    resources :posts, only: [:index, :show]
end
