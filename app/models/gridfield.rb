class Gridfield < ActiveRecord::Base
  belongs_to :map
  has_one :gridobject
  has_one :character
end
