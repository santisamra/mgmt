Mgmt::Application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "users/callbacks",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  post 'github/notifications/:organization/:name/issues' => "github_notifications#issues", as: 'issues_github_notifications'

  resources :projects, only: [:index, :show, :add_user] do
    member do
      get :settings
    end
    resources :milestones, only: [] do
      collection do
        patch :update
      end
    end
    resources :issues, only: [:update] do
      member do
        post :log_worked_hours
      end
    end

    resources :members, only: [:index] do
      member do
        post :delete
      end
    end
  end

  root :to => 'home#index'

  post "/projects/:project_id/members" => "members#add"
end
