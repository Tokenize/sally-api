require 'spec_helper'

describe Trip do
  it "has a valid factory" do
    expect(create(:trip)).to be_valid
  end

  it "is invalid without an associated user" do
    expect(build(:trip, user: nil)).to be_invalid
  end

  it "is invalid without a name" do
    expect(build(:trip, name: nil)).to be_invalid
  end

  it "is invalid without a start_at timestamp" do
    expect(build(:trip, start_at: nil)).to be_invalid
  end

  it "is valid with an empty description" do
    expect(build(:trip, description: nil)).to be_valid
  end

  it "is valid with an empty end_at timestamp" do
    expect(build(:trip, end_at: nil)).to be_valid
  end
end
