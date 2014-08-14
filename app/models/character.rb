class Character < ActiveRecord::Base
  belongs_to :team
  has_one :gridfield
end
