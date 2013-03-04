Mgmt::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/callbacks" }

  resources :projects, only: [:index, :show]
  
  root :to => 'home#index'
end
