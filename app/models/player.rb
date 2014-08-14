class Player < ActiveRecord::Base
  has_many :games
  validates_uniqueness_of :username, :email
  validates :username, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end