class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :team_id
      t.string :char_type
      t.integer :action_points_left
      t.integer :speed
      t.integer :life_points_left
      t.string :graphic_url

      t.timestamps
    end
  end
end
