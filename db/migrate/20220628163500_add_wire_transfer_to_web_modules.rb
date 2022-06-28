class AddWireTransferToWebModules < ActiveRecord::Migration[6.1]
  def change
    add_column :cadmin_web_modules, :wire_transfer, :boolean, default: false
  end
end
