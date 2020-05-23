# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def github 
   
    @user = User.find_for_github_auth(request.env['omniauth.auth']) 
    unless @user
      githubinfo = {}
      githubinfo[:provider] = request.env['omniauth.auth'][:provider]
      githubinfo[:uid] = request.env['omniauth.auth'][:uid]
      githubinfo[:nickname] = request.env['omniauth.auth'][:info][:nickname]
      githubinfo[:email] =  "#{request.env['omniauth.auth'][:uid]}-#{request.env['omniauth.auth'][:provider]}@example.com"  
      githubinfo[:password] =  Devise.friendly_token[0, 20]
      @user = User.new(githubinfo)
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = githubinfo[:password]
      @identification = @user.build_identification
      render template: 'devise/registrations/new_identification'
    else
      if @user.persisted?  
        sign_in_and_redirect @user, event: :authentication  
        set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?  
      else  
        session['devise.github_data'] = request.env['omniauth.auth']  
        redirect_to new_user_registration_path
      end  
    end
  end  

  def failure  
    redirect_to root_path  
  end 

 
  
end
