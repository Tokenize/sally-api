require 'spec_helper'

describe Location do
  it "has a valid factory" do
    expect(create(:location)).to be_valid
  end

  describe "validations" do
    it "is invalid without a time" do
      expect(build(:location, time: nil)).to have(1).errors_on(:time)
    end

    it "is invalid without a longitude" do
      expect(build(:location, longitude: nil)).to have(1).errors_on(:longitude)
    end

    it "is invalid without a latitude" do
      expect(build(:location, latitude: nil)).to have(1).errors_on(:latitude)
    end

    it "is invalid without an associated trip" do
      expect(build(:location, trip: nil)).to have(1).errors_on(:trip_id)
    end
  end
end
