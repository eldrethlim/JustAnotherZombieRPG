class Game < ActiveRecord::Base
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'
  belongs_to :current_turn_team, class_name: 'Team'
  belongs_to :map

  def self.setup(attrs)
    transaction do
      game = Game.create(attrs)
      map = game.create_map
      30.times do |y| 
        30.times do |x| 
          gridfield = map.gridfields.create(y: 30-y, x: x+1)
          gridfield.create_gridobject(traversible: true)
        end
      end
      game
    end
  end
end