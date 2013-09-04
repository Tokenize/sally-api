require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Locations < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

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
        trip = current_user.trips.where(id: params[:trip_id]).first
        
        if trip.nil?
          error!('Invalid trip_id.', 400)
        else
          trip.locations.create!(location_params)
        end
      end
    end

  end
end
