module Cadmin
  module PermissionLevel
    extend ActiveSupport::Concern

    def user?
      %w(user employee admin superadmin).include?(self.role)
    end
    def employee?
      %w(employee admin superadmin).include?(self.role)
    end
    def admin?
      %w(admin superadmin).include?(self.role)
    end
    def superadmin?
      %w(superadmin).include?(self.role)
    end
  end
end