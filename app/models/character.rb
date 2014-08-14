class Character < ActiveRecord::Base
  belongs_to :team
  has_many :gridfields
end
