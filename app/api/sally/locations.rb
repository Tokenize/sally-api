require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Locations < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

    rescue_from ActiveRecord::RecordNotFound

    before do
      authenticated_user
    end

    resource :trips do

      desc "Return a trip's locations"
      params do
        requires :trip_id, type: Integer, desc: "Trip id."
      end
      get ":trip_id/locations" do
        trip = current_user.trips.where(id: params[:trip_id]).first
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
        trip.locations.create!(location_params)
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

        location.latitude = location_params[:latitude] unless location_params[:latitude].blank?
        location.longitude = location_params[:longitude] unless location_params[:longitude].blank?
        location.direction = location_params[:direction] unless location_params[:direction].blank?
        location.speed = location_params[:speed] unless location_params[:speed].blank?

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
