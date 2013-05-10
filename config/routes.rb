Mgmt::Application.routes.draw do

  devise_for :users, controllers: { 
    omniauth_callbacks: "users/callbacks",
    registrations: "users/registrations", 
    passwords: "users/passwords"
  }

  post 'github/notifications/:organization/:name/issues' => "github_notifications#issues", as: 'issues_github_notifications'

  resources :projects, only: [:index, :show] do
    member do
      get :settings
      post :update_settings
    end
    resources :issues, only: [:update] do
      member do
        post :log_worked_hours
      end
    end
    member do
      post :add_user
      post :delete_user
    end

  end
  
  root :to => 'home#index'
end
