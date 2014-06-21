Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  get '/dashboard' => 'dashboard#index'

  resources :orders, except: [:show]
end
