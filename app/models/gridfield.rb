class Gridfield < ActiveRecord::Base
  belongs_to :map
  belongs_to :gridobject
  belongs_to :character
end