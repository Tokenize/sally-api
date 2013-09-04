require 'spec_helper'
describe 'Sally::Locations' do
  before :each do
    @user = create(:user)
    @trip = create(:trip, user: @user)
    @location = create(:location, trip: @trip)
  end

  context "authenticated user" do
    before :each do
      @token = @user.authentication_token
    end

    describe 'GET trip/:trip_id/locations' do
      it "responds with an 'OK (200)' status" do
        get "api/trips/#{@trip.id}/locations", { auth_token: @token }
        expect(response.response_code).to eq 200
      end

      it "returns all of the trip's locations" do
        get "api/trips/#{@trip.id}/locations", { auth_token: @token }
        body = JSON.parse(response.body)
        expect(body.count).to eq 1
      end
    end

    describe 'POST trip/:trip_id/locations' do
      context "success" do

        let(:attrs) { build(:location).attributes }

        it "creates a new location" do
          expect do
            post "api/trips/#{@trip.id}/locations", { auth_token: @token }.merge(attrs)
          end.to change(Location, :count).by(1)
        end

        it "returns the id of the newly created location" do
          post "api/trips/#{@trip.id}/locations", { auth_token: @token }.merge(attrs)
          body = JSON.parse(response.body)
          expect(body['id']).to_not be_blank
        end
      end

      context "failure" do
        let(:attrs) { build(:location).attributes }

        it "responds with a bad request (400) status given a bad trip_id" do
          post "api/trips/-1/locations", { auth_token: @token }.merge(attrs)
          expect(response.response_code).to eq 400
        end
      end
    end
  end

  context "unauthenticated user" do
    it "responds with an 'unauthorized (401)' status" do
      get "api/trips/#{@trip.id}/locations"
      expect(response.response_code).to eq 401
    end
  end
 end