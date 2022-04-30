class CreateCadminStockByDates < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_stock_by_dates do |t|
      t.references :service, null: false, foreign_key: {to_table: :cadmin_services}
      t.integer :stock
      t.string :date

      t.timestamps
    end
  end
end
