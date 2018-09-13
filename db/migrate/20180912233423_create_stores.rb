class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :title
      t.string :email
      t.string :address
      t.string :city
      t.integer :state_id
      t.string :zip

      t.timestamps
    end
  end
end
