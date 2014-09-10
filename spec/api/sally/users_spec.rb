require 'spec_helper'
describe 'Sally::Users' do
  before :each do
    @password = 'password123'
    @user = create(:user, password: @password)
  end

  describe 'GET sign_in' do
    it "returns an auth_token when given a valid email and password" do
      get 'api/users/sign_in', { email: @user.email, password: @password }
      expect(response.response_code).to eq 200
      expect(response.body).to match(/"#{@user.authentication_token}"/)
    end

    it "returns an error when given an invalid email and password" do
      get 'api/users/sign_in', { email: @user.email, password: 'bad' }
      expect(response.response_code).to eq 401
      expect(response.body).to match(/invalid email or password/i)
    end
  end

  describe "GET user" do
    context "success" do
      before(:each) do
        @user = create(:user)
        @token = @user.authentication_token
      end

      it "returns the authenticated user" do
        get 'api/user', { auth_token: @token }

        json_response = JSON.parse(response.body)

        expect(response).to be_success

        %w(first_name last_name email).each do |key|
          expect(json_response).to have_key(key)
        end
      end
    end

    context "failure" do
      it "returns a 401 error" do
        get 'api/user', { auth_token: 'invalid' }

        expect(response.response_code).to be(401)
      end
    end
  end
end
