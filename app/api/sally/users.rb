require 'helpers/auth_helpers'

module Sally
  class Users < Grape::API
    helpers AuthHelpers

    desc "Returns a user's authentication token."
    params do
      requires :email, type: String, desc: "Email address."
      requires :password, type: String, desc: "Password."
    end
    get "users/sign_in" do
      user = User.where(email: params[:email]).first
      if user && user.valid_password?(params[:password])
        user.authentication_token
      else
        error!('Invalid email or password', 401)
      end
    end

    resource :user do
      before do
        authenticated_user
      end

      desc "Return the authenticated user"
      get do
        current_user
      end
    end
  end
end
