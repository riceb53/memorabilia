class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :year_made
      t.string :player
      t.string :quality
      t.text :notes
      t.integer :user_id
      t.integer :store_id
      t.boolean :confirmed
      t.decimal :value, precision: 7, scale: 2

      t.timestamps
    end
  end
end
