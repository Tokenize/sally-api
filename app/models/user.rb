class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  has_many :trips

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
