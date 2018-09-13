class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :card_id
      t.integer :runs
      t.integer :hits
      t.decimal :ba, precision: 5, scale: 4
      t.integer :hr
      t.integer :sb
      t.integer :year_played

      t.timestamps
    end
  end
end
