class AddCharIdToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :character_id, :integer
  end
end
