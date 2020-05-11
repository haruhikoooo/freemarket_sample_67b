Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'users/address' => 'users/registrations#new_address'
    post 'users/address' => 'users/registrations#create_address'
    get 'users/complete' => 'users/registrations#complete'
    get 'users/logout' => 'users/sessions#logout'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'goods#index'

  resources :goods, only: [:index, :new, :show] do
    get 'parchase' => 'goods#parchase'
  end
  
  resources :users, only: [:show] do
    resources :payments, only: [:index, :new, :create, :destroy, :edit]
  end

end


