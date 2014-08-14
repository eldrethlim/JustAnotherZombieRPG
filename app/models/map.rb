class Map < ActiveRecord::Base
  has_many :gridfields
  has_one :game
end
