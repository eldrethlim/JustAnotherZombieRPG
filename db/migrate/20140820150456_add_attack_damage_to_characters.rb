class AddAttackDamageToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :attack_damage, :integer
  end
end
