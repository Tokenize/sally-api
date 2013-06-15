class Location < ActiveRecord::Base
  attr_accessible :direction, :latitude, :longitude, :speed, :time, :trip_id

  belongs_to :trip

  validates :time, :longitude, :latitude, :trip_id, presence: true
end
