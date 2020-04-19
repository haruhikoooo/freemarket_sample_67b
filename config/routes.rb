Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'users/step2' => 'users/registrations#step2'
    get 'users/complete' => 'users/registrations#complete'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'goods#index'

  resources :goods, only: [:index]
end
