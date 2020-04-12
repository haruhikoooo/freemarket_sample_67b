Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get "users/sign_up" => "devise/registrations#step1"
    get 'users/step2' => 'users/registrations#step2'
    get 'users/complete' => 'users/registrations#complete'
  end

end
