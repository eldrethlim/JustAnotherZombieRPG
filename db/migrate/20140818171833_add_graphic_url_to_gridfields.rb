class AddGraphicUrlToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :graphic_url, :string
  end
end
