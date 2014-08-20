class AddPlayerIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :player_id, :integer
  end
end
