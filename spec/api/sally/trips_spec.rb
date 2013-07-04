require 'spec_helper'
describe 'GET trips' do
  before :each do
    @user = create(:user)
    @trip = create(:trip, user: @user)
    @token = @user.authentication_token
  end
  
  context "authenticated user" do
    it "responds with an 'OK (200)' status" do
      get 'api/trips', { auth_token: @token }
      expect(response.response_code).to eq 200
    end
  end

  context "unauthenticated user" do
    it "responds with an 'unauthorized (401)' status" do
      get 'api/trips'
      expect(response.response_code).to eq 401
    end 
  end
end
