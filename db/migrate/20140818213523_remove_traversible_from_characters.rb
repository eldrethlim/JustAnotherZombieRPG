class RemoveTraversibleFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :traversible, :boolean
  end
end
