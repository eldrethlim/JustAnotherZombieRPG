class Team < ActiveRecord::Base
  has_many :characters
  has_one :game
  belongs_to :player

  def check_team_action_points
    total = Array.new

    self.characters.each do |character|
      total.push character.action_points_left
    end

    if total.inject(:+) == 0
      true
    else
      false
    end
  end
end