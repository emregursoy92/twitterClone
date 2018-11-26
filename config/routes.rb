Rails.application.routes.draw do
  devise_for :users

  get 'profile', to: 'home#user_page'
  get 'home', to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

end
