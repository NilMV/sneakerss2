Rails.application.routes.draw do
  devise_for :users
  resources :feeds do
    member do
     resources :entries, only: [:index, :show]
    end
  end
  get 'search', to: 'search#search'
  root 'feeds#index'
end
