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

        it "responds with a bad request (404) status given a bad trip_id" do
          post "api/trips/-1/locations", { auth_token: @token }.merge(attrs)
          expect(response.response_code).to eq 404
        end
      end
    end

    describe "PUT trip/:trip_id/locations/:id" do

      before(:each) do
        @location2 = create(:location, trip: @trip)
      end

      context "success" do
        let(:attrs) { { latitude: (@location2.latitude + 1) } }

        it "is successful when given valid parameters" do
          put "api/trips/#{@trip.id}/locations/#{@location2.id}", { auth_token: @token }.merge(attrs)
          expect(response).to be_success
        end

        it "updates the location's latitude" do
          put "api/trips/#{@trip.id}/locations/#{@location2.id}", { auth_token: @token }.merge(attrs)

          @location2.reload
          expect(@location2.latitude).to be_within(0.01).of(attrs[:latitude])
        end
      end

      context "failure" do
        let(:attrs) { { latitude: 'north pole' } }

        it "is not successful" do
          put "api/trips/#{@trip.id}/locations/#{@location2.id}",
            { auth_token: @token }.merge(attrs)
          expect(response).to_not be_success
        end

        it "does not update the location's attributes" do
          put "api/trips/#{@trip.id}/locations/#{@location2.id}",
            { auth_token: @token }.merge(attrs)
          @location2.reload

          expect(@location2.latitude).to_not eq(attrs[:latitude])
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
          expect(response.response_code).to eq(404)
        end

        it "does not delete another user's locations" do
          trip = create(:trip)
          location = create(:location, trip: trip)

          expect do
            delete "api/trips/#{@trip.id}/locations/#{location.id}", { auth_token: @token }
          end.to_not change(Location, :count)

          expect(response.response_code).to eq(404)
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
