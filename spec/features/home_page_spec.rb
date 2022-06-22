require "rails_helper"

RSpec.describe "The home page" do
  describe "for a signed out user" do
    it "requires them to sign in" do
      # user = nil

      visit "/"

      expect(page).to have_content("Sign in")
      expect(page).to_not have_content("Rooms")
    end

    it "allows them to sign in" do
      user = create(:user)

      visit "/"

      fill_in "Username", with: user.username
      click_on "Sign in"

      expect(page).to have_content("Successfully signed in as #{user.username}")
    end
  end

  describe "for a signed in user" do
    it "allows them to sign out" do
      user = create(:user)

      sign_in(user)
      expect(page).to have_content("Sign out")
      click_on "Sign out"

      expect(page).to have_content("Successfully signed out")
      expect(page).to_not have_content("Sign out")
    end

    it "displays the list of all usernames on the platform" do
      user_2 = create(:user, username: "second_user")
      user_3 = create(:user, username: "third_user")
      user = create(:user)

      sign_in(user)

      expect(page).to have_content(user_2.username)
      expect(page).to have_content(user_3.username)
    end

    it "displays the total of all other usernames on the platform" do
      5.times { create(:user) }
      user = create(:user)
      total_number_of_users = User.all.count - 1

      sign_in(user)

      expect(page).to have_content(I18n.t("rooms.index.users", number: total_number_of_users))
    end

    it "displays display room names" do
      room_1 = create(:room)
      room_2 = create(:room, name: "Room 2")
      room_3 = create(:room, name: "Room 3", is_private: false)

      user = create(:user)

      sign_in(user)

      expect(page).to have_content(room_1.name)
      expect(page).to have_content(room_2.name)
      expect(page).to have_content(room_3.name)
    end

    it "displays the total of all rooms on the platform" do
      5.times { create(:room) }
      user = create(:user)
      total_number_of_rooms = Room.all.count

      sign_in(user)

      expect(page).to have_content(I18n.t("rooms.index.rooms", number: total_number_of_rooms))
    end
  end

  private

  def sign_in(user)
    visit "/"

    fill_in "Username", with: user.username
    click_on "Sign in"
  end
end
