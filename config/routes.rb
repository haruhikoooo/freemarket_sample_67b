Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'users/address' => 'users/registrations#new_address'
    post 'users/address' => 'users/registrations#create_address'
    get 'users/complete' => 'users/registrations#complete'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'goods#index'
  get 'goods/category', to: 'goods#category_index'
  get 'get_category_children', to: 'goods#get_category_children', defaults: { format: 'json' }
  get 'get_category_grandchildren', to: 'goods#get_category_grandchildren', defaults: { format: 'json' }
  resources :goods, only: [:index, :new, :show]

  

end


