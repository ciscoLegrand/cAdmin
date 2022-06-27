module Cadmin
  class UserInvitationsController < Devise::InvitationsController
    before_action :initial_invited_cadmin_user, only: [:new, :edit]
    add_breadcrumb 'Usuarios'
    def new
      add_breadcrumb 'Invitar usuario'
      render 'cadmin/user_invitations/new', locals: { resource: @user, resource_name: resource_name }
    end

    def create
      @password = SecureRandom.hex(8)
      @user = Cadmin::User.new(invited_cadmin_user_params)
      @user.password = @password
      @user.save!
      if @user.valid?
        @user.update!(
          invitation_created_at: Time.now,
          invitation_sent_at: Time.now,
          invited_by_id: current_cadmin_user.id
        )
        UserMailer.invitation_instructions(@user,@password).deliver_now
        redirect_to root_path, success: "Se acaba de enviar un email de activación a  #{@user.email}."
      else 
        redirect_to root_path, error: "Algo ha salido mal y no se pudo enviar la invitación."
      end

    end

    def update
      user = Cadmin::User.accept_invitation!(initial_invited_cadmin_user)
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