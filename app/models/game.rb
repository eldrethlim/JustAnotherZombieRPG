class Game < ActiveRecord::Base
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'
  belongs_to :current_turn_team, class_name: 'Team'
  belongs_to :map

  def self.setup(attrs)
    game = Game.create(attrs)
    map = game.create_map
    30.times do |x| 
      30.times do |y| 
        gridfield = map.gridfields.create(x: x+1, y: y+1)
        gridfield.create_gridobject(traversible: true)
      end
    end
  end
end

# Make a new game controller (create a new game action)
# Show list of players
# Game setup, then redirect to game show page (should show grid)
# | t | t | t |