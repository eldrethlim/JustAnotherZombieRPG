class Gridfield < ActiveRecord::Base
  belongs_to :map
  belongs_to :gridobject
  belongs_to :character

  def is_there_nothing_here?
    self.character == nil && self.gridobject == nil
  end

  def is_there_a_char_here?
    self.character != nil
  end

  def is_there_an_object_here?
    self.gridobject == nil
  end

  def character_belongs_to_player?(current_player)
    self.character.team.player == current_player
  end
end