Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  unauthenticated do
    root 'pages#home'
  end

  authenticated do
    root 'pages#redirect'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
