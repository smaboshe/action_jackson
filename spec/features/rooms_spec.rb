require "rails_helper"

RSpec.describe "Rooms" do
  it "displays display their room names" do
    room_1 = create(:room)
    room_2 = create(:room, name: "Room 2")
    room_3 = create(:room, name: "Room 3", is_private: false)
    user_2 = create(:user, username: "second_user")
    user_3 = create(:user, username: "third_user")
    user = create(:user)

    sign_in(user)

    expect(page).to have_content(user_2.username)
    expect(page).to have_content(user_3.username)
    expect(page).to have_content(room_1.name)
    expect(page).to have_content(room_2.name)
    # expect(page).to_not have_content(room_3.name)
  end

  it "rejects a user who is not logged in" do
  end

  it "accepts a user who is logged in" do
  end

  private

  def sign_in(user)
    visit "/"

    fill_in "Username", with: user.username
    click_on "Sign in"
  end
end
