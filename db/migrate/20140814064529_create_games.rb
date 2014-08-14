class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.integer :map_id
      t.integer :team1_id
      t.integer :team2_id
      t.integer :current_turn_team_id

      t.timestamps
    end
  end
end
