class AddTraversibleToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :traversible, :boolean
  end
end
