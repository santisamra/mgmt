Mgmt::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/callbacks" }

  resources :projects, only: [:index, :show] do
    resources :issues, only: [:update]
  end
  
  root :to => 'home#index'
end
