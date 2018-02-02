Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # Defining root depending on whether logged in or not
  unauthenticated do
    root 'pages#home'
  end
  authenticated do
    root 'pages#call_facebook'
  end

  get '/redirect', to: 'pages#redirect', as: 'redirect'

  # GROUPS CONTROLLERS
  resources :groups, only: [:show, :update, :destroy]
  get '/new_kitty', to: 'groups#new_kitty', as: 'new_group'
  get '/reminder', to: 'groups#reminder', as: 'groups_reminder'

  # USERS CONTROLLERS
  resources :users, only: [:show]
  get '/transactions/:id', to: 'users#transactions', as: 'user_transactions'
  get '/friends/:id', to: 'users#friends', as: 'user_friends'
  get '/dashboard/:id', to: 'users#dashboard', as: 'user_dashboard'
  get '/settle_all', to: 'users#settle_all', as: 'user_settle_all'

  # EXPENSES CONTROLLERS
  resources :expenses, only: [:new, :create, :show]
  post '/expenses/upload', to: 'expenses#upload', as: 'expenses_upload'

  # WEBHOOKS CONTROLLER
  get 'webhooks', to: 'webhooks#messenger'
  post 'webhooks', to: 'webhooks#messenger_receive_message'

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [ :create ]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
