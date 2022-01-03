 module Cadmin 
  module PermissionLevel
    extend ActiveSupport::Concern

    def user?
      %w(user).include?(self.role)
    end

    def customer?
      %w(customer).include?(self.role)
    end

    def employee?
      %w(employee).include?(self.role)
    end
    def admin?
      %w(admin superadmin).include?(self.role)
    end
    def superadmin?
      %w(superadmin).include?(self.role)
    end
  end
end
