module AuthHelpers
  def warden
    env['warden']
  end

  def unauthorized_error!
   error!({ code: 401, message: "Access denied."}, 401)
  end

  def current_user
    warden.user || User.where(authentication_token: params[:auth_token])
  end

  def authenticated
      unauthorized_error! unless (warden.authenticated? || current_user)
  end

  def authenticated_user
    authenticated
    unauthorized_error! unless current_user
  end

end
