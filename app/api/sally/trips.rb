require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Trips < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

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
        current_user.trips.where(id: params[:id]).first
      end

      desc "Creates a trip."
      params do
        requires :name, type: String, desc: "Trip name"
        requires :start_at, type: Time, desc: "Trip start time"
      end
      post do
        current_user.trips.create!(trip_params)
      end
    end

  end
end
