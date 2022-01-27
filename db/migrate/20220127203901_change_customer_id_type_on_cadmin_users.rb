class ChangeCustomerIdTypeOnCadminUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :cadmin_users, :customer_id, :string 
    rename_column :cadmin_users, :customer_id, :stripe_customer_id
  end
end
