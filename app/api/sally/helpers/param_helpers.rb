module ParamHelpers
  def clean_params
    ActionController::Parameters.new(params)
  end

  def trip_params
    clean_params.permit(:id, :name, :description, :start_at, :end_at).presence || params
  end
end
