require 'spec_helper'

describe User do
  
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "has an authentication token when created" do
    user = create(:user)
    expect(user.authentication_token).not_to eq(nil)
  end

  describe "validations" do
    it "is invalid without a first_name" do
      expect(build(:user, first_name: nil)).to have(1).errors_on(:first_name)
    end

    it "is invalid without a last_name" do
      expect(build(:user, last_name: nil)).to have(1).errors_on(:last_name)
    end

    it "is invalid without an email address" do
      expect(build(:user, email: nil)).to have(1).errors_on(:email)
    end

    it "is invalid with a duplicate email address" do
      create(:user, email: "example@example.com")
      user = build(:user, email: "example@example.com")
      expect(user).to have(1).errors_on(:email)
    end

    it "is invalid without a password" do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it "is invalid with a mismatched password and confirmation" do
      expect(build(:user, password: 'test1234', 
                    password_confirmation: 'test4321')).not_to be_valid
    end

    it "is invalid with a short password" do
      expect(build(:user, password: 'a', password_confirmation: 'a')).not_to \
             be_valid
    end
  end
end
