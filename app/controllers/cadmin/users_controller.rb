class Cadmin::UsersController < ApplicationController
  before_action :set_title
  before_action :set_user, only: [:edit, :update, :show]


  def index 
    @users = Cadmin::User.all.order(created_at: :desc)#.where(role: 'customer') 
  end
  # todo: edit & update users && user account | soft delete user account | 

  def edit 
    @page_title = @user.username.capitalize
    add_breadcrumb "Editar #{@user.username.capitalize}"
  end

  def show
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to usuarios_registrados_path, notice: "Usuario actualizado correctamente" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end
  
  def reset_password 
    @user = Cadmin::User.find_by_email(params[:email])
    if @user.present?
      @token = SecureRandom.hex(8)
      Cadmin::UserMailer.reset_password(@user, @token).deliver_now
      redirect_to main_app.root_path, notice: "Se ha enviado un correo con la nueva contraseña temporal"
    else
      redirect_to main_app.root_path, notice: "El email introducido no coincide con ningún usuario"
    end
  end

  private
  def set_user
    @user = Cadmin::User.friendly.find(params[:id])
  end
  def user_params
    #? NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:email, :username, :name, :last_name,:phone, :address, :password, :password_confirmation)
  end

  def set_title
    @title = 'Usuarios'
  end
end
