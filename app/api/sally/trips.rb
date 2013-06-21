module Sally
  class Trips < Grape::API
    desc "Returns all trips."
    get :trips do
     Trip.all
    end
  end
end
