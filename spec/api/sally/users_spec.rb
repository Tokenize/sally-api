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
end
