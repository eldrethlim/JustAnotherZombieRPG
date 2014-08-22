class AddSomeoneDiedHereToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :someone_died_here, :boolean
  end
end
