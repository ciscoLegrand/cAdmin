module Cadmin
  class UserInvitationsController < Devise::InvitationsController
    before_action :initial_invited_cadmin_user, only: [:new, :edit]
    add_breadcrumb 'Usuarios'
    def new
      add_breadcrumb 'Invitar usuario'
      render 'cadmin/user_invitations/new', locals: { resource: @user, resource_name: resource_name }
    end
    # todo: how manage mailers after send invitation???

    # def edit
    #   render 'users/invitations/edit', locals: { resource: @user, resource_name: resource_name }
    # end

    def create
      @user = Cadmin::User.invite!(invited_cadmin_user_params) do |user|
        # todo: review this section 'cause dont sending emails and uses skip_invitations only for not broke this part!
        user.skip_invitation = true
      end
      
      @user = Cadmin::User.new(invited_cadmin_user_params)
      
      if @user.valid?
        # Cadmin::User.invite!(invited_cadmin_user_params)
        redirect_to events_path, notice: "Se acaba de enviar un email de activación a  #{invited_cadmin_user_params[:email]}."
      else        
        render 'cadmin/user_invitations/new', locals: { resource: @user, resource_name: resource_name }, notice: "No se ha podido enviar el email a  #{invited_cadmin_user_params[:email]}."
      end
    end

    def update
      user = Cadmin::User.accept_invitation!(invited_user_params)
      if user.valid?
        redirect_to root_path, notice: ''
      else
        super
      end
    end 

    private 
    
      def initial_invited_cadmin_user
        @user = User.find_by_invitation_token(params[:invitation_token], true) || User.new
      end

      def invited_cadmin_user_params
        params.require(:cadmin_user).permit(:name, :username, :last_name,:phone,:email,:address,:city,:province,:postal_code, :role, :password, :password_confirmation, :invitation_token)
      end
  end
end