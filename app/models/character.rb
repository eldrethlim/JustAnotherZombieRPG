class Character < ActiveRecord::Base
  belongs_to :team
  has_one :gridfield

  def can_move_to?(gridfield)
    p1 = self.gridfield
    p2 = gridfield
    distance = Math.sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
    distance < speed
  end

  def can_attack_range?(gridfield)
    p1 = self.gridfield
    p2 = gridfield
    distance = Math.sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
    if distance < range
      distance
    else
      false
    end
  end

  def hit_chance(distance)
    hit = rand(99) + 1
    if distance > 6 && hit > 30
      true
    elsif distance.between?(3, 6) && hit > 20
      true
    elsif distance < 3
      true
    end
  end

  def reset_tile(gridfield)
    gridfield.update(graphic_url: 'GrassTile.png')
  end

  def action_points_left?
    if self.action_points_left > 0
      true
    else
      false
    end
  end

  def relocate_character(old_gridfield, new_gridfield)
    self.update(action_points_left: self.action_points_left - 1)
    if gridfield.someone_died_here == true
      old_gridfield.update(character_id: nil, graphic_url: 'DeadChar.png')
    else
      old_gridfield.update(character_id: nil, graphic_url: 'GrassTile.png')
    end
    new_gridfield.update(character_id: self.id, graphic_url: 'SelectedTile.png')
  end

  def check_if_dead?
    if self.life_points_left <= 0
      self.gridfield.update(graphic_url: 'DeadChar.png', someone_died_here: true)
      self.destroy
    end
  end

  def consume_action_points
    self.update(action_points_left: self.action_points_left - 1)
  end
end