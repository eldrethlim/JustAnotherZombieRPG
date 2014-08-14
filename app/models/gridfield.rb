class Gridfield < ActiveRecord::Base
  belongs_to :map
  belongs_to :gridfield
  belongs_to :character
end
