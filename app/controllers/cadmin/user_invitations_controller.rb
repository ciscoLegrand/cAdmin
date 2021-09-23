module Cadmin
  class UserInvitationsController < Devise::InvitationsController
    # before_action :initial_invited_user, only: [:new, :edit]

    # def new
    #   render 'users/invitations/new', locals: { resource: @user, resource_name: resource_name }
    # end

    # # def edit
    # #   render 'users/invitations/edit', locals: { resource: @user, resource_name: resource_name }
    # # end

    def create
      @user = User.invite!(invited_cadmin_user_params)
      if @user.valid?
        redirect_to root_path, notice: "Se acaba de enviar un email de activación a  #{invited_cadmin_user_params[:email]}."
      else        
        render 'users/invitations/new', locals: { resource: @user, resource_name: resource_name }, notice: "No se ha podido enviar el email a  #{invited_cadmin_user_params[:email]}."
      end
    end

    # def update
    #   user = User.accept_invitation!(invited_user_params)
    #   if user.valid?
    #     redirect_to root_path, notice: ''
    #   else
    #     super
    #   end
    # end 

    private
    
      def initial_invited_cadmin_user
        @user = User.find_by_invitation_token(params[:invitation_token], true) || User.new
      end

      def invited_cadmin_user_params
        params.require(:cadmin_user).permit(:name, :username, :last_name,:phone,:email, :role, :password, :password_confirmation, :invitation_token)
      end
  end
end