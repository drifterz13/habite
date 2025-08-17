Rails.application.routes.draw do
  get "pages/home"
  get "pages/shop"

  resource :session
  resources :passwords, param: :token
  resource :profile, only: %i[show]

  resources :quests, only: %i[index show] do
    member do
      post :start
      patch :complete
    end

    resources :tasks, only: %i[show] do
      member do
        patch :complete
      end
    end
  end

  resources :monsters, only: %i[index] do
    resources :monster_rewards, only: %i[index], as: :rewards

    member do
      post :attack
    end
  end

  namespace :gm do
    resources :monsters, only: %i[new create]

    resources :quests, only: %i[new create destroy] do
      resources :tasks, only: %i[new create]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"
end
