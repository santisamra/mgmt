Mgmt::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/callbacks" }

  resources :repositories, only: [:index, :show]
  
  root :to => 'home#index'
end
