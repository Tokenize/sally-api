module ParamHelpers
  def clean_params
    ActionController::Parameters.new(params)
  end

  def trip_params
    clean_params.permit(:name, :description, :start_at, :end_at)
  end
end
