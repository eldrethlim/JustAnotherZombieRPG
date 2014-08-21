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
end
