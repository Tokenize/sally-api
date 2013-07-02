class Location < ActiveRecord::Base
  belongs_to :trip

  validates :time, :longitude, :latitude, :trip_id, presence: true
end
