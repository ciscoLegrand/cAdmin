module Cadmin
  class UserInvitationsController < Devise::InvitationsController
    before_action :initial_invited_cadmin_user, only: [:new, :edit]
    add_breadcrumb 'Usuarios'
    def new
      add_breadcrumb 'Invitar usuario'
      render 'cadmin/user_invitations/new', locals: { resource: @user, resource_name: resource_name }
    end
    # TODO: how manage mailers after send invitation???

    # def edit
    #   render 'users/invitations/edit', locals: { resource: @user, resource_name: resource_name }
    # end

    def create
      # TODO: 
      # @user = Cadmin::User.invite!(invited_cadmin_user_params) do |user|
      #   # TODO: review this section 'cause dont sending emails and uses skip_invitations only for not broke this part!
      #   user.skip_invitation = true
      #   UserMailer.invitation_instructions(user, user.invitation_token).deliver_now
      # end
      @password = invited_cadmin_user_params[:password]
      @user = Cadmin::User.create!(invited_cadmin_user_params)
      if @user.valid?
        @user.update!(
          invitation_created_at: Time.now,
          invitation_sent_at: Time.now,
          invited_by_id: current_cadmin_user.id
        )
        UserMailer.invitation_instructions(@user,@password).deliver_now
        redirect_to root_path, success: "Se acaba de enviar un email de activación a  #{invited_cadmin_user_params[:email]}."
      else 
        redirect_to root_path, error: "Algo ha salido mal y no se pudo enviar la invitación."
      end

    end

    def update
      user = Cadmin::User.accept_invitation!(invited_cadmin_user_params)
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