module Cadmin
  module ApplicationHelper
    include Pagy::Frontend

    #! display select roles
    def permitted_roles
      current_cadmin_user.superadmin? ? [['Usuario', 'user'],['Empleado', 'employee'], ['Administrador', 'admin'], ['Superadministrador', 'superadmin']] : [['Usuario', 'user'],['Empleado', 'employee'], ['Administrador', 'admin']]
    end
  end
end
