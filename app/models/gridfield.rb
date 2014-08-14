class Gridfield < ActiveRecord::Base
  belongs_to :map
  has_many :gridobjects
end
