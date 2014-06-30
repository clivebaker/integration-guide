
class RegistrationsController < Devise::RegistrationsController
 
  private
 
  def sign_up_params
    params.require(:user).permit(:name, :key, :secret, :retailer, :store, :email, :password, :password_confirmation, :loyalty_program)
  end
 
  def account_update_params
    params.require(:user).permit(:name, :key, :secret, :retailer, :store, :email, :password, :password_confirmation, :current_password, :loyalty_program)
  end
end