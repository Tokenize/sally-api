require 'spec_helper'

describe "navigation" do
  context "top navigation bar" do
    it "should have a top navigation bar" do
      visit root_path

      expect(page).to have_selector('nav.top-bar')
    end

    it "should have a linkable title to the root path" do
      visit root_path

      expect(page).to have_link('Sally API', href: root_path)
    end
  end
end
