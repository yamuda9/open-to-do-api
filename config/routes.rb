Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
