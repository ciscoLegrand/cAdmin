module Cadmin
  module ApplicationHelper
    include Pagy::Frontend

    #! display select roles
    def permitted_roles
      current_cadmin_user.superadmin? ? [['Usuario', 'user'],['Empleado', 'employee'], ['Administrador', 'admin'],['Cliente','customer'], ['Superadministrador', 'superadmin']] : [['Usuario', 'user'],['Empleado', 'employee'], ['Cliente', 'customer'],['Administrador', 'admin']]
    end

    def permitted_status
      [['Pendiente', 'pending'],['Publicado', 'published'],['Unpublicado','unpublished'],['Borradores','drafts']]
    end
  end
end
