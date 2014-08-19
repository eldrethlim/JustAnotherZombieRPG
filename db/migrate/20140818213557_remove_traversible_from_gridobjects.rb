class RemoveTraversibleFromGridobjects < ActiveRecord::Migration
  def change
    remove_column :gridobjects, :traversible, :boolean
  end
end
