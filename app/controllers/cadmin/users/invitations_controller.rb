class Users::InvitationsController < Devise::InvitationsController
  # before_action :initial_invited_user, only: [:new, :edit]

  # def new
  #   render 'users/invitations/new', locals: { resource: @user, resource_name: resource_name }
  # end

  # # def edit
  # #   render 'users/invitations/edit', locals: { resource: @user, resource_name: resource_name }
  # # end

  def create
    @user = Cadmin::User.invite!(invited_user_params)
    if @user.valid?
      redirect_to root_path, notice: "Se acaba de enviar un email de activación a  #{invited_user_params[:email]}."
    else
      
      render 'users/invitations/new', locals: { resource: @user, resource_name: resource_name }, notice: "No se ha podido enviar el email a  #{invited_user_params[:email]}."
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
   
    def initial_invited_user
      @user = User.find_by_invitation_token(params[:invitation_token], true) || User.new
    end

    def invited_user_params
      params.require(:cadmin_user).permit(:name, :username, :commercial_name, :business_name,:email, :role, :password, :password_confirmation, :invitation_token)
    end
end