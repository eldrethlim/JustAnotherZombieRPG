class AddAttackGraphicUrlToGridfields < ActiveRecord::Migration
  def change
    add_column :gridfields, :attack_graphic_url, :string
  end
end
