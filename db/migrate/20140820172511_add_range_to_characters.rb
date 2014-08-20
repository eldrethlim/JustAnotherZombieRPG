class AddRangeToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :range, :integer
  end
end
