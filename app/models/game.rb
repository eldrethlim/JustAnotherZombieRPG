class Game < ActiveRecord::Base
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'
  belongs_to :map

  def self.setup(attrs)
    transaction do
      game = Game.create(attrs)
      map = game.create_map
      team1 = Team.create(player_id: game.player1.id)
      team2 = Team.create(player_id: game.player2.id)
      game.update(team1: team1, team2: team2, current_player_turn_id: game.player1.id)
      
      # Create map tiles
      30.times do |y| 
        30.times do |x| 
          gridfield = map.gridfields.create(y: 30-y, x: x+1, graphic_url: 'GrassTile.png', attack_graphic_url: 'AttackTile.png', traversible: true, someone_died_here: false)
        end
      end

      # Create lake on map
      x = [19, 20, 21, 22, 23, 24, 18, 19, 20, 21, 22, 23, 24, 25, 26, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 21, 22, 23, 24, 25, 26]
      y = [23, 23, 23, 23, 23, 23, 22, 22, 22, 22, 22, 22, 22, 22, 22, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 18, 18, 18, 18, 18, 18]
      x.zip(y).each do |x,y|
        gridfield = map.gridfields.find_by(x: x, y: y)
        gridobject = gridfield.create_gridobject(graphic_url: 'water.png')
        gridfield.update(gridobject: gridobject, traversible: false)
      end

      # Create rocks on map
      x = [3, 4, 6, 7, 9, 11, 15, 19, 23, 25]
      y = [4, 23, 20, 7, 21, 17, 8, 10, 6, 15]
      x.zip(y).each do |x,y|
        gridfield = map.gridfields.find_by(x: x, y: y)
        gridobject = gridfield.create_gridobject(graphic_url: 'rock.png')
        gridfield.update(gridobject: gridobject, traversible: false)
      end

      # Create trees on map
      x = [2, 3, 3, 4, 5, 6, 6, 7, 9, 9, 9, 9, 10, 11, 12, 13, 13, 13, 14, 15, 15, 17, 17, 18, 18, 19, 20, 21, 23, 23, 25, 25, 25, 27, 27, 27, 28, 28]
      y = [18, 10, 27, 17, 12, 24, 4, 14, 27, 17, 11, 5, 8, 21, 25, 19, 11, 5, 15, 22, 18, 27, 12, 16, 5, 7, 15, 27, 17, 9, 27, 12, 5, 25, 10, 3, 17, 7] 
      x.zip(y).each do |x,y|
        gridfield = map.gridfields.find_by(x: x, y: y)
        gridobject = gridfield.create_gridobject(graphic_url: 'tree.png')
        gridfield.update(gridobject: gridobject, traversible: false)
      end

      # Create human characters on map
      x = [12, 14, 16, 18]
      x.each do |x| 
        human = team1.characters.create(graphic_url: 'Soldier.png', char_type: 'Human', action_points_left: 2, speed: 4, life_points_left: 2, attack_damage: 3, range: 8)
        map.gridfields.find_by(x: x, y: 1).update(character: human, traversible: false)
      end

      # Create zombie characters on map
      x = [9, 12, 15, 18, 21]
      x.each do |x|
        zombie = team2.characters.create(graphic_url: 'Zombie.png', char_type: 'Zombie', action_points_left: 2,speed: 5, life_points_left: 6, attack_damage: 3, range: 2)
        map.gridfields.find_by(x: x, y: 30).update(character: zombie, traversible: false)
      end

      game
    end
  end

  def current_team
    if self.current_player_turn_id == self.player1.id
      self.team1
    else
      self.team2
    end
  end

  def latest_update
    self.update(last_update: Time.now)
  end

  def process_end_turn(characters)
    characters.each do |character|
      character.update(action_points_left: 2)
    end

    self.map.gridfields.where(graphic_url: 'SelectedTile.png').each do |gridfield|
      gridfield.update(graphic_url: 'GrassTile.png')
    end

    if self.current_player_turn_id == self.player1.id
      self.update(current_player_turn_id: self.player2.id)
    else
      self.update(current_player_turn_id: self.player1.id)
    end
  end

  def perform_attack(target, attacker)
    target.update(life_points_left: target.life_points_left - attacker.attack_damage)
  end

  def my_turn?(current_player)
    self.current_player_turn_id == current_player.id
  end

  def one_team_has_no_members?
    self.team1.has_no_members? || self.team2.has_no_members?
  end

  def check_who_won?
    if self.team1.has_no_members?
      "Zombies"
    else
      "Humans"
    end
  end
end