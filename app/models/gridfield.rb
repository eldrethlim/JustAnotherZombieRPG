class Gridfield < ActiveRecord::Base
  belongs_to :map
  has_many :gridobjects
  has_many :characters
end
