class Map < ActiveRecord::Base
  has_many :gridfields
  has_many :games
end
