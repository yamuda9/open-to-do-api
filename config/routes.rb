Rails.application.routes.draw do
  resources :users, only: [ :new, :create ]

  namespace :api, defaults: { format: :json } do
    resources :users
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
