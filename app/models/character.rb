class Character < ActiveRecord::Base
  belongs_to :team
  belongs_to :gridfield
end
