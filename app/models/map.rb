class Map < ActiveRecord::Base
  has_many :gridfields, dependent: :destroy
  has_one :game, dependent: :destroy
end