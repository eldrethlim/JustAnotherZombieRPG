class RemoveCurrentTurnTeamFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :current_turn_team_id, :integer
  end
end
