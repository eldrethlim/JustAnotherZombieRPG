class RemoveNameFromMaps < ActiveRecord::Migration
  def change
    remove_column :maps, :name, :string
  end
end
