Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' , to: 'application#index', as: 'welcome'
  get '/admin', to: 'admin#login'
  post '/admin', to: 'admin#create', as: 'create_session'
  scope 'admin', as: 'admin' do
    resources :posts, only: [:new, :edit, :create, :update, :destroy]
  end
    resources :posts, only: [:index, :show]
end
