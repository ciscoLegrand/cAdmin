# This migration comes from cadmin (originally 20210907195017)
class CreateCadminWebModules < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_web_modules do |t|
      t.boolean :blog
      t.boolean :gallery
      t.boolean :paypal
      t.boolean :stripe
      t.boolean :adyen
      t.boolean :opinions
      t.boolean :newsletter
      t.boolean :reservation

      t.timestamps
    end
  end
end
