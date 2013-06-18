require 'spec_helper'

describe Trip do
  it "has a valid factory" do
    expect(create(:trip)).to be_valid
  end

  describe "validations" do
    it "is invalid without an associated user" do
      expect(build(:trip, user: nil)).to have(1).errors_on(:user_id)
    end

    it "is invalid without a name" do
      expect(build(:trip, name: nil)).to have(1).errors_on(:name)
    end

    it "is invalid without a start_at timestamp" do
      expect(build(:trip, start_at: nil)).to have(1).errors_on(:start_at)
    end

    it "is valid with an empty description" do
      expect(build(:trip, description: nil)).to be_valid
    end

    it "is valid with an empty end_at timestamp" do
      expect(build(:trip, end_at: nil)).to be_valid
    end
  end
end
