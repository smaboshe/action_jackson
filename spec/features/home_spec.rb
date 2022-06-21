require "rails_helper"

RSpec.describe "The home page" do
  it "requires a user to be logged in" do
    # user = nil

    visit "/"

    expect(page).to have_content("Sign in")
    expect(page).to_not have_content("Rooms")
  end

  it "allows a user to log in" do
    user = create(:user)

    visit "/"

    fill_in "Username", with: user.username
    click_on "Sign in"

    expect(page).to have_content("Successfully signed in as #{user.username}")
  end

  it "allows a signed in user to sign out in" do
    user = create(:user)

    visit "/"

    fill_in "Username", with: user.username
    click_on "Sign in"

    expect(page).to have_content("Sign out")

    click_on "Sign out"

    expect(page).to have_content("Successfully signed out")
    expect(page).to_not have_content("Sign out")
  end
end
