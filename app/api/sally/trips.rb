require 'helpers/auth_helpers'
module Sally
  class Trips < Grape::API
    helpers AuthHelpers

    desc "Returns all trips."
    get :trips do
      authenticated_user
      current_user.trips.to_a
    end
  end
end
