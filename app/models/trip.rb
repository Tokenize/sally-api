class Trip < ActiveRecord::Base
  attr_accessible :description, :end_at, :name, :start_at

  belongs_to :user
  has_many :locations
end
