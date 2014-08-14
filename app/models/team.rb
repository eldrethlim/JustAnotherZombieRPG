class Team < ActiveRecord::Base
  has_many :characters
  belongs_to :player
  has_many :games
end
