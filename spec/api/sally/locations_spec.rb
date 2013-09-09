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

        it "responds with a bad request (403) status given a bad trip_id" do
          post "api/trips/-1/locations", { auth_token: @token }.merge(attrs)
          expect(response.response_code).to eq 403
        end
      end
    end

    describe "DELETE trip/:trip_id/locations/:id" do
      context "success" do

        before :each do
          @new_location = create(:location, trip: @trip)
        end

        it "decrements the number of locations by 1" do
          expect do
            delete "api/trips/#{@trip.id}/locations/#{@new_location.id}", { auth_token: @token }
          end.to change(Location, :count).by(-1)
        end

        it "returns the deleted location" do
          delete "api/trips/#{@trip.id}/locations/#{@new_location.id}", { auth_token: @token }
          body = JSON.parse(response.body)
          expect(body['id']).to eq(@new_location.id)
        end
      end

      context "failure" do
        before :each do
          @new_location = create(:location, trip: @trip)
        end

        it "does not change the number of locations" do
          expect do
            delete "api/trips/#{@trip.id}/locations/#{@new_location.id + 1}", { auth_token: @token }
          end.to_not change(Location, :count)
        end

        it "returns an error when attempting to delete a non-existant location" do
          delete "api/trips/#{@trip.id}/locations/#{@new_location.id + 1}", { auth_token: @token }
          expect(response.response_code).to eq(403)
        end

        it "does not delete another user's locations" do
          trip = create(:trip)
          location = create(:location, trip: trip)

          expect do
            delete "api/trips/#{@trip.id}/locations/#{location.id}", { auth_token: @token }
          end.to_not change(Location, :count)

          expect(response.response_code).to eq(403)
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
