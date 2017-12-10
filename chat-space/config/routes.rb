Rails.application.routes.draw do
  devise_for :users
	root "messages#index"
  resources :group, only: [:new, :create, :update, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
