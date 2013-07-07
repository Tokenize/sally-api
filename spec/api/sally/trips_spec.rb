require 'spec_helper'
describe 'Sally::Trips' do
  before :each do
    @user = create(:user)
  end

  context "authenticated user" do
    before :each do
      @trip1 = create(:trip, user: @user)
      @trip2 = create(:trip, user: @user)
      @token = @user.authentication_token
    end

    it "responds with an 'OK (200)' status" do
      get 'api/trips', { auth_token: @token }
      expect(response.response_code).to eq 200
    end

    describe 'GET trips' do
      it "returns the users trips" do
        get 'api/trips', { auth_token: @token }
        body = JSON.parse(response.body)
        expect(body.count).to eq 2
      end
    end

    describe 'GET trips/:id' do
      it "returns a specific trip when given a trip id" do
        get "api/trips/#{@trip1.id}", { auth_token: @token }
        body = JSON.parse(response.body)
        expect(body['id']).to eq @trip1.id
      end

    end
  end

  context "unauthenticated user" do
    it "responds with an 'unauthorized (401)' status" do
      get 'api/trips'
      expect(response.response_code).to eq 401
    end 
  end
end

