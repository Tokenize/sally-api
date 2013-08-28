require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Trips < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

    rescue_from ActiveRecord::RecordNotFound

    before do
      authenticated_user
    end

    resource :trips do

      desc "Returns all trips."
      get do
        current_user.trips.to_a
      end

      desc "Return a trip."
      params do
        requires :id, type: Integer, desc: "Trip id."
      end
      get ":id" do
        current_user.trips.where(id: trip_params[:id]).first
      end

      desc "Creates a trip."
      params do
        requires :name, type: String, desc: "Trip name"
        requires :start_at, type: Time, desc: "Trip start time"
      end
      post do
        current_user.trips.create!(trip_params)
      end

      desc "Delete a trip."
      params do
        requires :id, type: String, desc: "Trip ID."
      end
      delete ":id" do
        current_user.trips.find(trip_params[:id]).destroy
      end
    end

  end
end
