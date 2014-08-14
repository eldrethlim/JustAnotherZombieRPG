class AddCharIdToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :char_object_id, :integer
  end
end
