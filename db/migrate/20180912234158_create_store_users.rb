class CreateStoreUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :store_users do |t|
      t.integer :store_id
      t.integer :user_id

      t.timestamps
    end
  end
end
