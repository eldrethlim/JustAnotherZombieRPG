class Team < ActiveRecord::Base
  has_many :characters
  has_one :game
  belongs_to :player
end
