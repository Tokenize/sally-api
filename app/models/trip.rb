class Trip < ActiveRecord::Base
  attr_accessible :description, :end_at, :name, :start_at,
    :user_id

  belongs_to :user
  has_many :locations

  validates :user_id, :name, :start_at, presence: true
  validates_associated :locations
end
