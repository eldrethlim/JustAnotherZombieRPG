class Team < ActiveRecord::Base
  has_many :characters
  has_many :games
end
