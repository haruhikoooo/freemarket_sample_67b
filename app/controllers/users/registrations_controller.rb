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

  # def create
  #   # render :new_address 
  # end

  def select_registration
  end

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @identification = @user.build_identification
    render :new_identification
  end

  def new_identification
  end

  def create_identification
    @user = User.new(session["devise.regist_data"]["user"])
    @identification = Identification.new(identification_params)
    unless @identification.valid?
      flash.now[:alert] = @identification.errors.full_messages
      render :new_identification and return
    end
    session["identification_data"] = {identification: @identification.attributes}
    @address = @user.build_address
    render :new_address
  end

  def new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @identification = Identification.new(session["identification_data"]["identification"])
    @address = Address.new(address_params)
    unless @address.valid?
    flash.now[:alert] = @address.errors.full_messages
    render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.build_identification(@identification.attributes)
    @user.save
    sign_in(:user, @user)
    render :complete
  end

  def complete
  end

  protected

  def address_params
    params.require(:address).permit(:destination_family_name, :destination_first_name, :destination_furigana_family, :destination_furigana_first, :zipcode, :prefecture_id, :city, :house_number, :apartment_name, :tel)
  end

  def identification_params
    params.require(:identification).permit(:family_name, :first_name, :furigana_family, :furigana_first, :birthday)
  end

end
