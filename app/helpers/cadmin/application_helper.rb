module Cadmin
  module ApplicationHelper
    include Pagy::Frontend
    #! percentage of events by type for display in the dashboard index
    def event_percentage(id)
      begin
        (Event.where(event_type_id: id).count * 100) / Event.all.count 
      rescue 
        0
      end
    end
    def total_event_amount(id)
      Event.where(event_type_id: id).sum(&:total_amount)
    end
    #! display select roles
    def permitted_roles
      current_cadmin_user.superadmin? ? [['Usuario', 'user'],['Empleado', 'employee'], ['Administrador', 'admin'],['Cliente','customer'], ['Superadministrador', 'superadmin']] : [['Usuario', 'user'],['Empleado', 'employee'], ['Cliente', 'customer'],['Administrador', 'admin']]
    end
    #! display article status
    def permitted_status
      [['Pendiente', 'pending'],['Publicado', 'published'],['Unpublicado','unpublished'],['Borradores','drafts']]
    end

    #! options for sweetalert2
    def default_swal_options
      '{
        "title": "Estás seguro?",
        "text": "Una vez eliminado no podrás recuperar el registro",
        "icon": "warning",
        "showCancelButton": true,
        "confirmButtonText":  "Eliminar",
        "cancelButtonText": "Cancelar",
        "buttonsStyling": false,
        "customClass": {
          "confirmButton": "button is-danger mx-2",
          "cancelButton": "button is-light mx-2"
        }
      }'
    end
  end
end
