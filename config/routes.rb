Rails.application.routes.draw do
  get "pages/home"
  get "pages/boss", as: :boss_fight

  resource :session
  resources :passwords, param: :token
  resource :profile, only: %w[ show ]

  resources :quests do
    resources :tasks, only: %w[ show ]
  end

  namespace :gm do
    post :spawn_monster, to: "games#spawn_monster"

    resources :quests, only: [] do
      resources :tasks, only: %i[ new create ]
    end
  end

  resources :monsters, module: "player", only: [] do
    post :attack, on: :member, to: "games#attack_monster"
  end

  namespace :player do
    resources :quests, only: [] do
      patch :complete, on: :member, to: "quest_completions#complete"
      post :start, on: :member, to: "quest_starters#start"
    end

    resources :tasks, only: [] do
      patch :complete, on: :member, to: "task_completions#complete"
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
