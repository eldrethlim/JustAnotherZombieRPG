class AddLastUpdateToGame < ActiveRecord::Migration
  def change
    add_column :games, :last_update, :datetime
  end
end
