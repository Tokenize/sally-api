require 'helpers/auth_helpers'
module Sally
  class Trips < Grape::API
    helpers AuthHelpers

    before do
      authenticated_user
    end

    desc "Returns all trips."
    get :trips do
      current_user.trips.to_a
    end

    desc "Return a trip."
    params do
      requires :id, type: Integer, desc: "Trip id."
    end
    get "trips/:id" do
      current_user.trips.where(id: params[:id]).first
    end

  end
end
