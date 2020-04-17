# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def new
    @user = User.new
  end

  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_comfirmation] = user_params[:password_comfirmation]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:furigana_family] = user_params[:furigana_family]
    session[:furigana_first] = user_params[:furigana_first]
    session[:birthday] = user_params[:birthday]
    @address = Address.new
  end

  def complete
    session[:destination_family_name] = address_params[:destination_family_name]
    session[:destination_first_name] = address_params[:destination_first_name]
    session[:destination_furigana_family] = address_params[:destination_furigana_family]
    session[:destination_furigana_first] = address_params[:destination_furigana_first]
    session[:zipcode] = address_params[:zipcode]
    session[:prefecture_id] = address_params[:prefecture_id]
    session[:city] = address_params[:city]
    session[:house_number] = address_params[:house_number]
    session[:apartment_name] = address_params[:apartment_name]
    session[:tel] = address_params[:tel]
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :family_name, :first_name, :furigana_family, :furigana_first, :birthday)
  end

  def address_params
    params.require(:user).permit(:destination_family_name, :destination_first_name, :destination_furigana_family, :destination_furigana_first, :zipcode, :prefecture_id, :city, :house_number, :apartment_name, :tel)
  end


end
