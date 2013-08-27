require 'helpers/auth_helpers'
module Sally
  class Locations < Grape::API
    helpers AuthHelpers

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
    end

  end
end
