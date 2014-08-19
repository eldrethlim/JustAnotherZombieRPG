class AddTraversibleToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :traversible, :integer
  end
end
