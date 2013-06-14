class Location < ActiveRecord::Base
  attr_accessible :direction, :latitude, :longitude, :speed, :time

  belongs_to :trip
end
