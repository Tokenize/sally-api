require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Locations < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

    rescue_from :all
    rescue_from ActiveRecord::RecordNotFound do |e|
      Rack::Response.new({ error: "Location not found." }.to_json, 404).finish
    end

    before do
      authenticated_user
    end

    resource :trips do

      desc "Return a trip's locations"
      params do
        requires :trip_id, type: Integer, desc: "Trip id."
      end
      get ":trip_id/locations" do
        trip = current_user.trips.where(id: params[:trip_id]).first!
        trip.locations
      end

      desc "Creates a location"
      params do
        requires :time, type: Time, desc: "Timestamp as seconds since Epoch."
        requires :latitude, type: Float, desc: "Latitude value."
        requires :longitude, type: Float, desc: "Longitude value."
      end
      post ":trip_id/locations" do
        trip = current_user.trips.find(params[:trip_id])
        trip.locations.create!(new_location_params)
      end

      desc "Update a location"
      params do
        requires :id, type: Integer, desc: "Location id."
        optional :latitude, type: Float, desc: "Latitude value."
        optional :longitude, type: Float, desc: "Longitude value."
        optional :direction, type: String, desc: "Direction."
        optional :speed, type: Integer, desc: "Speed."
      end
      put ":trip_id/locations/:id" do
        trip = current_user.trips.find(params[:trip_id])
        location = trip.locations.find(location_params[:id])

        location.latitude = location_params[:latitude] if location_params.has_key?(:latitude)
        location.longitude = location_params[:longitude] if location_params.has_key?(:longitude)
        location.direction = location_params[:direction] if location_params.has_key?(:direction)
        location.speed = location_params[:speed] if location_params.has_key?(:speed)

        location.save!
        location
      end

      desc "Deletes a location"
      params do
        requires :id, type: Integer, desc: "Location id."
      end
      delete ":trip_id/locations/:id" do
        trip = current_user.trips.find(params[:trip_id])
        trip.locations.find(location_params[:id]).destroy
      end
    end

  end
end
