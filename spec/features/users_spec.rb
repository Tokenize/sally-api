require 'spec_helper'

describe "users" do

  context "sign up" do

    context "success" do
      it "should create and sign the user in" do
        visit "/users/sign_up"

        fill_in "First name", with: "John"
        fill_in "Last name", with: "Doe"
        fill_in "Email", with: "jdoe@tokenize.ca"
        fill_in "Password", with: "12345678"
        fill_in "Password confirmation", with: "12345678"
        click_button "Sign up"

        expect(page).to have_link("sign out")
      end
    end

    context "failure" do
      it "should not create the user nor sign the user in" do
        visit "/users/sign_up"

        fill_in "First name", with: "John"
        fill_in "Last name", with: "Doe"
        fill_in "Email", with: "jdoe@tokenize.ca"
        fill_in "Password", with: "12345678"
        click_button "Sign up"

        expect(page).to_not have_link("sign out")
      end
    end
  end
end
