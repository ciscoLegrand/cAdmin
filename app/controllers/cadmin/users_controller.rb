class Cadmin::UsersController < ApplicationController
  before_action :authenticate_cadmin_user!
  befor_action :set_title

  def pending
    @page_title = "Usuarios pendientes de registro"
    add_breadcrumb 'Usuarios invitados'
    @pending = Cadmin::User.where(invitation_accepted_at: nil).all 
    # todo: complete pending action and views
  end

  def active
    @page_title = "Usuarios activos"
    add_breadcrumb 'Usuarios activos'
    @active = Cadmin::User.where.not(sign_in_count: 0).all 
    # todo: complete active action and views
  end 

  # todo: edit & update users && user account | soft delete user account | active users | 

  private 

  def set_title
    @page_title = 'Usuarios'
  end
end
