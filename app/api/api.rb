class API < Grape::API
  prefix "api"
  format :json

  mount Sally::Trips
  mount Sally::Users
  mount Sally::Locations
end
