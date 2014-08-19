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
      team1 = Team.create
      team2 = Team.create
      game.update(team1: team1, team2: team2)
      
      # Create map tiles
      30.times do |y| 
        30.times do |x| 
          gridfield = map.gridfields.create(y: 30-y, x: x+1, graphic_url: 'GrassTile.png', traversible: true)
        end
      end

      # Create level objects on map
      x = [1, 2, 3, 4]
      y = [1, 2, 3, 4]
      x.zip(y).each do |x,y|
        gridfield = map.gridfields.find_by(x: x, y: y)
        gridobject = gridfield.create_gridobject(graphic_url: '')
        gridfield.update(gridobject: gridobject, traversible: false)
      end

      # Create human characters on map
      x = [12, 14, 16, 18]
      x.each do |x| 
        human = team1.characters.create(graphic_url: 'Soldier.png', char_type: 'Human', action_points_left: 2, speed: 4, life_points_left: 2)
        map.gridfields.find_by(x: x, y: 1).update(character: human, traversible: false)
      end

      # Create zombie characters on map
      x = [9, 12, 15, 18, 21]
      x.each do |x|
        zombie = team2.characters.create(graphic_url: 'Zombie.png', char_type: 'Zombie', action_points_left: 2,speed: 5, life_points_left: 6)
        map.gridfields.find_by(x: x, y: 30).update(character: zombie, traversible: false)
      end

      game
    end
  end
end