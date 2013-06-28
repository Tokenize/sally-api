class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :locations

  validates :user_id, :name, :start_at, presence: true
  validates_associated :locations
end
