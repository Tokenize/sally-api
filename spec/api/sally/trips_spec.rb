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

    describe 'POST trips' do
      context "success" do
        let(:attrs) { build(:trip).attributes }

        it "creates a new trip" do
          expect do
            post "api/trips", { auth_token: @token }.merge(attrs)
          end.to change(Trip, :count).by(1)
        end

        it "should return the id of the newly created trip" do
          post "api/trips", { auth_token: @token }.merge(attrs)
          body = JSON.parse(response.body)
          expect(body['id']).to_not be_blank
        end
      end

      context "failure" do
        let(:attrs) { build(:trip).attributes.reject { |k, v| k == 'name' } }

        it "should not create a new trip" do
          expect do
            post "api/trips", { auth_token: @token }.merge(attrs)
          end.to_not change(Trip, :count)
        end

        it "should populate the 'error' element" do
          post "api/trips", { auth_token: @token }.merge(attrs)
          body = JSON.parse(response.body)
          expect(body['error']).to_not be_blank
        end
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

