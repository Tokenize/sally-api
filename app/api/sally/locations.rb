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
