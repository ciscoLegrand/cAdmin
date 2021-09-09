module Cadmin
  class UserRegistrationsController < Devise::RegistrationsController

    private
      def sign_up_params
        params.require(:cadmin_user).permit(:name, :username, :email,:phone, :password, :password_confirmation)
      end
  end
end