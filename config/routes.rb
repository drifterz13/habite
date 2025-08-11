Rails.application.routes.draw do
  get "pages/home"

  resource :session
  resources :passwords, param: :token
  resources :quests do
    resources :tasks, only: %w[ show new ] do
      patch :complete, on: :member, to: "player/task_completions#complete"
    end

    patch :complete, on: :member, to: "player/quest_completions#complete"
    post :start, on: :member, to: "player/quest_starters#start"
  end

  namespace :gm do
    resource :profile, only: %w[ show ]
  end

  namespace :player do
    resource :profile, only: %w[ show ]
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
