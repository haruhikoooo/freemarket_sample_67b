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
  root 'goods#toppage'

  get 'goods/category', to: 'goods#category_index'
  get 'get_category_children', to: 'goods#get_category_children', defaults: { format: 'json' }
  get 'get_category_grandchildren', to: 'goods#get_category_grandchildren', defaults: { format: 'json' }
  get 'get_image', to: 'goods#get_image', defaults: { format: 'json' }
  
  resources :goods, only: [:index, :new, :show, :create, :edit, :destroy] do
    get 'parchase' => 'goods#parchase'
  end
  
  resources :users, only: [:show] do
    resources :payments, only: [:index, :new, :create, :destroy]
  end

  resources :goods, only: [:new, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end


