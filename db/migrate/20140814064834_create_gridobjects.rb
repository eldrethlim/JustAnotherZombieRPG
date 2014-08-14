class CreateGridobjects < ActiveRecord::Migration
  def change
    create_table :gridobjects do |t|
      t.boolean :traversible?
      t.string :graphic_url

      t.timestamps
    end
  end
end
