Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  
  devise_scope :user do
    get "users/sign_up" => "devise/registrations#step1"
    get 'users/step2' => 'users/registrations#step2'
    get 'users/complete' => 'users/registrations#complete'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'goods#index'

  resources :goods, only: [:index]
  resources :users, only: [:index]
end
