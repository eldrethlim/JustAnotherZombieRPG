class AddCurrentPlayerTurnToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_player_turn_id, :integer
  end
end
