module Cadmin
  class UserRegistrationsController < Devise::RegistrationsController
    before_action :sign_up_params, only: [:create, :update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # # POST /resource
    # def create
    #   super
    # end

    # # GET /resource/edit
    # def edit
    #   super
    # end

    # # PUT /resource
    # def update
    #   super
    # end
    private
      def sign_up_params
        params.require(:cadmin_user).permit(:name, :username, :email,:phone, :password, :password_confirmation, :avatar)
      end
      def after_sign_up_path_for(resource)
        UserMailer.welcome(resource).deliver_now
        main_app.root_path
      end
  end
end