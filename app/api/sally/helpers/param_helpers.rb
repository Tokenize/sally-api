module ParamHelpers
  def clean_params
    ActionController::Parameters.new(params)
  end

  def trip_params
    clean_params.permit(:id, :name, :description, :start_at, :end_at).presence || params
  end

  def new_trip_params
    clean_params.permit(:name, :description, :start_at, :end_at).presence || params
  end

  def location_params
    clean_params.permit(:id, :time, :latitude, :longitude, :direction, :speed).presence || params
  end

  def new_location_params
    clean_params.permit(:time, :latitude, :longitude, :direction, :speed).presence || params
  end
end
