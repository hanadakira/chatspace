Rails.application.routes.draw do
  devise_for :users
	root "groups#index"
  resources :users, only: [:index,:edit,:update]
  resources :groups, only: [:index,:new, :create, :update, :edit] do
    resources :messages
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
