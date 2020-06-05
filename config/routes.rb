Rails.application.routes.draw do
  if Rails.env.development?
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      omniauth_callbacks: "users/omniauth_callbacks"
    }
  end

  if Rails.env.production?
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
  end


  devise_scope :user do
    get 'users/select_registration' => 'users/registrations#select_registration'
    get 'users/identification' => 'users/registrations#new_identification'
    post 'users/identification' => 'users/registrations#create_identification'
    get 'users/address' => 'users/registrations#new_address'
    post 'users/address' => 'users/registrations#create_address'
    get 'users/complete' => 'users/registrations#complete'
    get 'users/logout' => 'users/sessions#logout'
  end

  namespace :goods do
    resources :searches, only: :index
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'goods#toppage'

  get 'goods/category', to: 'goods#category_index'
  
  get 'get_category_children', to: 'goods#get_category_children', defaults: { format: 'json' }
  get 'get_category_grandchildren', to: 'goods#get_category_grandchildren', defaults: { format: 'json' }
  get 'get_image', to: 'goods#get_image', defaults: { format: 'json' }
  
  resources :goods do
    resources :deals, only: [:new, :create, :show]
  end
  
  resources :users, only: [:show] do
    resources :payments, only: [:index, :show, :new, :create, :destroy]
  end

  
  resources :goods, only: [:new, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :buys, only: [:index] do
  end

  resources :categories, only: [:show]
  resources :likes, only: [:show] do
    collection do
      get 'create', defaults: { format: 'json' }
      get 'destroy', defaults: { format: 'json' }
    end
  end

  resources :likes, only: [:show] do
    collection do
      get 'create', defaults: { format: 'json' }
      get 'destroy', defaults: { format: 'json' }
    end
  end

  resources :likes, only: [:show] do
    collection do
      get 'create', defaults: { format: 'json' }
      get 'destroy', defaults: { format: 'json' }
    end
  end

end


