class CreateGridfields < ActiveRecord::Migration
  def change
    create_table :gridfields do |t|
      t.integer :map_id
      t.integer :x
      t.integer :y
      t.integer :grid_object_id

      t.timestamps
    end
  end
end
