require 'helpers/auth_helpers'
require 'helpers/param_helpers'

module Sally
  class Trips < Grape::API
    helpers AuthHelpers
    helpers ParamHelpers

    rescue_from :all
    rescue_from ActiveRecord::RecordNotFound do |e|
      Rack::Response.new({ error: "Trip not found." }.to_json, 404).finish
    end

    before do
      authenticated_user
    end

    resource :trips do

      desc "Returns all trips."
      get do
        current_user.trips.to_a
      end

      desc "Return a trip."
      params do
        requires :id, type: Integer, desc: "Trip id."
      end
      get ":id" do
        current_user.trips.where(id: trip_params[:id]).first!
      end

      desc "Creates a trip."
      params do
        requires :name, type: String, desc: "Trip name"
        requires :start_at, type: Time, desc: "Trip start time"
      end
      post do
        current_user.trips.create!(new_trip_params)
      end

      desc "Update a trip."
      params do
        requires :id, type: String, desc: "Trip ID."
        optional :name, type: String, desc: "Trip's name."
        optional :description, type: String, desc: "Trip's description."
        optional :start_at, type: Time, desc: "Trip's start time."
        optional :end_at, type: Time, desc: "Trip's end time."
      end
      put ":id" do
        trip = current_user.trips.find(trip_params[:id])

        trip.name = trip_params[:name] unless trip_params[:name].blank?
        trip.description = trip_params[:description] unless trip_params[:description].blank?
        trip.start_at = trip_params[:start_at] unless trip_params[:start_at].blank?
        trip.end_at = trip_params[:end_at] unless trip_params[:end_at].blank?

        trip.save!

        trip
      end

      desc "Delete a trip."
      params do
        requires :id, type: String, desc: "Trip ID."
      end
      delete ":id" do
        current_user.trips.find(trip_params[:id]).destroy
      end
    end

  end
end
