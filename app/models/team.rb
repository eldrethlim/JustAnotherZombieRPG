class Team < ActiveRecord::Base
  has_many :characters
  has_one :game
  belongs_to :player

  def has_no_members?
    self.characters.count == 0
  end

  def has_team_action_points?
    total = Array.new

    self.characters.each do |character|
      total.push character.action_points_left
    end
    
    total.inject(:+) == 0
  end
end