class Location < ActiveRecord::Base
  belongs_to :trip
  attr_accessible :direction, :latitude, :longitude, :speed, :time
end
