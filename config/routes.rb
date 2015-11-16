Rails.application.routes.draw do
  resources :users, only: [ :new, :create ]

  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end

    resources :lists, only: [] do
      resources :items, only: [ :create ]
    end

    resources :items, only: [ :destroy ]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
