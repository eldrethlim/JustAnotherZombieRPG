class Game < ActiveRecord::Base
  has_many :players
  has_many :teams
  has_many :maps
end
