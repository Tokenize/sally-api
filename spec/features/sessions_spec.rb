require 'spec_helper'

describe "sessions" do
  context "sign in" do
    let(:user) { FactoryGirl.create(:user, :password => "secret12") }

    context "valid credentials" do

      it "should sign the user in" do
        visit "/users/sign_in"

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"

        expect(page).to have_link("sign out")
      end
    end

    context "invalid credentials" do

      it "should not sign the user in" do
        visit "/users/sign_in"

        fill_in "Email", with: user.email
        fill_in "Password", with: "invalid"
        click_button "Sign in"

        expect(page).to_not have_link("sign out")
      end
    end
  end
end
